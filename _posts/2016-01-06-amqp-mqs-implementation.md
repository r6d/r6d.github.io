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

## Mise en oeuvre avec RabbitMQ

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
 
 * [rabbitmq-hutch-11-638.jpg](http://images.google.fr/imgres?imgurl=http%3A%2F%2Fimage.slidesharecdn.com%2Frabbitmqandhutch-130813050114-phpapp01%2F95%2Frabbitmq-hutch-11-638.jpg)
* [BayFP_RabbitMQ_talk_20090408](http://www.rabbitmq.com/resources/BayFP_RabbitMQ_talk_20090408.pdf)
* [Introduction to RabbitMQ & Hands on](http://ambuj4bigdata.blogspot.fr/2015/02/introduction-to-rabbitmq-hands-on.html)

Accronymes : 

MQS : Message Queing Service, service de gestion de message en file d'attente

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
