---
layout: post
title: "Architecture Orientée Message, Implémentation"
date: 2016-01-06 18:00:000 +0100
comments: false
tags: [amqp, rabbitmq, mom, implementation]
---

# Architecture de services Orientée Messages, Implémentation

Ce document présente une réalisation de [l'architecture présentée dans un autre article](/2015/12/amqp-mqs-specification/).
Pour mémoire cette architecture est composée de 2 familles d'applications (producteur de messages et consommateur) qui échangent des messages par l'intermédiaire d'un broker. 

L'outil, le broker de messages sélectionné est RabbitMQ.

ZeroMQ est réputé pour être plus performant mais pas pour son interface de gestion.
Cette solution est populaire pour la performance brute ce qui n'est pas le but recherché pour le moment.

Quelques tests menés sur un ordinateur portable montrent que RabbitMQ peut supporter un flux de 20k messages par secondes de manière soutenue (3h) ce qui est largement suffisant pour le cahier des charges.

Pour ceux qui veulent directement le schéma d'implémentation, [c'est par là](#schéma) .

## Introduction au routage de message avec RabbitMQ

Pour une explication globale des concept de routage de message, [c'est par ici](https://www.rabbitmq.com/tutorials/amqp-concepts.html).

Pour simplifier au maximum, le service assurant le dispatch des messages est composé d'un point d'échange auquel un producteur envoie des messages, ainsi que de files d'attente qui stockent les messages devant être récupérés par des consommateurs.
Selon la configuration (type de point d'échange, "binding") un message peut être remis à 0, 1 ou plusieurs consommateurs.

L'intérêt d'utiliser un outil pour faire cette fonction est multiple :

* séparer les producteur des consommateurs (= par de lien logiciel fort entre les deux parties)
* réaliser l'inversion de contrôle ([IoC](https://en.wikipedia.org/wiki/Inversion_of_control)) permettant de pouvoir lancer les applications dans le sens que l'on souhaite sans s'occuper de l'ordre des traitements (= pas besoin de faire de résolution de dépendances).
* pas besoin de réinventer la roue de la communication réseau avec les problèmes associés (outil de supervision ...)

* différents modes de routage de messages

![exemple 1](/assets/files/2016/01/rabbitmq-hutch-11-638.jpg)

* Exemple d'utilisation de la clef de routage

Le routage par motif permet de router un message dans plusieurs files d'attentes.

Dans cet exemple, la clef de routage associée aux messages est composée d'une partie géographique (europe, ...) et une autre partie qui indique la nature (news, ....) du message.

Les files d'attentes ont la possibilité de choisir :

* un type d'information particulier pour une zone spécifique (europe.news),
* tous les messages d'une zone spécifique (europe.#),
* un type d'information particulier pour toutes les zones (#.news),
* tous les messages pour toutes les zones (#)

![exemple 2](/assets/files/2016/01/20150914161921517.png)

## Mise en oeuvre avec RabbitMQ

### Les messages

On distingue différents types de messages par leur famille d'utilisation :

1. les messages de log
	Ce type de message est transformé dans une chaine d'opération pour permettre l'analyse ultérieure d'une situation.
	Le flux de messages est unidirectionnel.
	Généralement un traitement des messages en lot est possible.
1. les messages interactifs
	Ce type de message est en fait une demande d'action et peut nécessiter une réponse.
	Le flux de messages est unidirectionnel.
	Généralement, un traitement le plus rapide possible est souhaité.

### Les acteurs

Services *produisant* des messages :

|Type |Où ?                |Nom des services                                                |
|-----|--------------------|----------------------------------------------------------------|
|log  |Local (machine)     |dns, mail, postgresql, syslog, ssh, web                         |
|log  |Distant (réseau LAN)|relevé de température (arduino)                                 |
|log  |Distant (internet)  |github, jira, twitter                                           |

Application *consommant* des messages :

|Type |Où ?                |Nom des services                                                |
|-----|--------------------|----------------------------------------------------------------|
|log  |Local (machine)     |logstash                                                        |
|log  |Distant (réseau LAN)|envois de mail                                                  |
|log  |Distant (internet)  |visualisation log en temps réel dans navigateur                 |
|app  |Local (machine)     |zonecheck (vérification config DNS), indexation site web, redimensionnement d'image        |

### Organisation du broker de messages

La présence d'une interface d'administration pour rRabbitMQ permet de voir rapidement l'ensemble des points d'échanges et des files d'attentes.
L'interface permet également de configurer les différents éléments ainsi que les relations.

Pour information, la configuration peut être effectuée par programme au travers des commandes AMQP définies dans le standard.

#### Point d'échange

Plusieurs solutions sont possibles pour faire communiquer tout ce monde :

1. un point d'échange par type de message = 1 point d'échange "log" + 1 point d'échange "app"
1. un point d'échange par type de service = plein de point d'échanges
1. un mélange des autres solutions

|Solution|Avantage                                | Inconvénient                           |
|--------|----------------------------------------|----------------------------------------|
|1|rapide à mettre en place | le routage est obligatoire pour différentier les services par la clef de routage|
|2|voir facilement le traffic par service (graph), routage simple |longue liste de point d'échange|
|3|permet un maximum de souplesse|nécessité de vérifier la configuration pour chaque point d'échange car potentiellement spécifique à celui-là|

La solution 2 est celle sélectionnée ici.

#### Files d'attente

Dans l'optique d'uniformiser la configuration voici les propriétés appliquées :

* pour chaque point d'échange une file d'attente nommée est créée
* les messages insérés dans une file d'attente nommée expirent automatiquement
* la durée d'expiration des messages est suffisamment grande pour qu'une maintenance de l'application consommatrice ne pose pas de perte de message
* les files d'attente sont systématiquement associées à un point d'échange
* les applications doivent valider la réception du message après leur traitement
* les applications de visualisation doivent utiliser des files d'attentes anonymes (car elle n'ont pas d'opération à effectuer sur les messages)

#### Clef de routage

Dans la mesure du possible, il est conseillé de mettre dans la clef :

* le nom complet de la machine (FQDN) de manière inversée (le TLD en premier).
* le nom du service

Exemple de clefs :

* "eu.r6d.machineA.srv_www"
* "eu.r6d.machineB.srv_mail"
* "local.mon-pc.srv_mail"

Lors de la récupération des messages dans des files d'attentes spécifiques à des applications, il sera possible de récupérer :

* les messages du service mail par l'association de `#.srv_mail`
* les messages du domaine r6d.eu par l'association de `eu.r6d.#`

#### Scalabilité de la solution

La croissance peut intervenir à plusieurs parties du système.

Voici quelques solutions pour arriver à suivre la demande :

|Problème                          |Partie concernée|Solution                               |
|----------------------------------|----------------|---------------------------------------|
|L'app consommatrice est trop lente|sortie|Ajouter une autre instance de l'application sur la même file d'attente. Les messages seront consommés en rounb robin|
|L'app consommatrice reçoit des messages qui ne l'interresse pas|interne|il faut appliquer un filtrage sur la clef de routage pour sélectionner plus finement les messages|
|Le serveur de message est lent    |interne|N'y a-t-il pas trop de messages dans les files d'attente ? Il est possible d'augmenter les capacités avec une mise en cluster de RabbitMQ.|
|Le producteur n'envoie pas les messages aussi vite que d'habitude|entrée|RabbitMQ limite le débit en entrée lorsque les sorties sont saturée afin de limiter le nombre de messages en file d'attente. Essayer de consommer les messages plus rapidement.|


## Schéma

![schéma d'implémentation](/assets/files/2016/01/mqs-impl.png)

Besoin d'un peu plus d'information pour comprendre ? [c'est par là](#introduction-au-routage-de-message-avec-rabbitmq)

Légende :


* lien rouge --> indique que le schéma n'est pas terminé
* lien orange --> protocole STOMP
* lien jaune -->
* lien vert --> protocole MQTT
* lien bleu --> protocole AMQP

## En cours

Liens :
 
 * [Microservices with RabbitMQ and Docker, linkedin.com](https://www.linkedin.com/pulse/microservices-rabbitmq-docker-jairo-diaz),
 
	*  [même article sur le site d'origine, blog.codescrum.com](http://blog.codescrum.com/2014/12/16/Microservices_with_RabbitMQ_and_Docker/),
	* [exemple d'implémentation en ruby, github.com](https://github.com/codescrum/microservice-tests-01)

*  [BayFP_RabbitMQ_talk_20090408, rabbitmq.com](http://www.rabbitmq.com/resources/BayFP_RabbitMQ_talk_20090408.pdf)
*  [Introduction to RabbitMQ & Hands on, ambuj4bigdata.blogspot.fr](http://ambuj4bigdata.blogspot.fr/2015/02/introduction-to-rabbitmq-hands-on.html)
* [20150914161921517.png, img.blog.csdn.net](http://img.blog.csdn.net/20150914161921517)
*  [rabbitmq-hutch-11-638.jpg, image.slidesharecdn.com](http://images.google.fr/imgres?imgurl=http%3A%2F%2Fimage.slidesharecdn.com%2Frabbitmqandhutch-130813050114-phpapp01%2F95%2Frabbitmq-hutch-11-638.jpg)

Acronymes :

MQS : Message Queing Service, service de gestion de message en file d'attente

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
