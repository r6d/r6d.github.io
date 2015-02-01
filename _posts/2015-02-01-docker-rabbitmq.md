---
layout: post
title: "RabbitMQ et Docker"
date: 2015-02-01 16:34:000 +0100
comments: false
tags: [rabbitmq, amqp, docker]
---

# Utilisation rapide de RabbitMQ avec docker

[RabbitMQ](http://www.rabbitmq.com/) :

* un serveur de messagerie (= serveur permettant l'échange de message)
* implémente le protocole AMQP en version 0.9 et 1.0
* est édité par [Pivotal](http://www.pivotal.io/)

Notes :

* les commandes données ici n'ont pas vocation à conserver les données
* dès que les commandes sont terminées, les données produites dans le conteneur sont perdues.


## Instructions de lancement

D'après [mikaelhg](https://github.com/mikaelhg/docker-rabbitmq) :

```bash
docker run -it --rm -p 5672:5672 -p 15672:15672 mikaelhg/docker-rabbitmq
```

L'interface de gestion est disponible sur le port `15672` et AMQP est disponible sur le port `5672` comme avec une instance habituelle de RabbitMQ.


Docker fourni également une image officielle qui ne semble pas contenir l'interface de gestion.

```bash
docker run -it --rm rabbitmq
```

