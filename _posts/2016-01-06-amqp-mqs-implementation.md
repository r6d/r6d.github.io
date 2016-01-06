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


![schéma d'implémentation](/assets/files/2016/01/mqs-impl.png)

#

http://www.rabbitmq.com/resources/BayFP_RabbitMQ_talk_20090408.pdf
MQS : Message Queing Service, service de gestion de message en file d'attente

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
