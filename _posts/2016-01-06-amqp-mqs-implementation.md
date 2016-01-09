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

L'outil, le broker de messages choisi est RabbitMQ.

## Introduction au routage de message avec RabbitMQ

TODO

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

Services produisant des messages de log :

|Où ?              |Nom des services                         |
|------------------|-----------------------------------------|
|Local (machine)   |dns, mail, postgresql, syslog, ssh, web  |
|Distant (internet)|github, jira, twitter                    |



TODO

![schéma d'implémentation](/assets/files/2016/01/mqs-impl.png)

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

Accronymes : 

MQS : Message Queing Service, service de gestion de message en file d'attente

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
