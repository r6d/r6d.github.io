---
layout: post
title: "Fig et Docker"
date: 2015-02-05 16:58:000 +0100
comments: false
tags: [fig, docker]
---

# Lancement d'applications utilisant plusieurs containers docker avec fig

* [instructions officielles d'installation](http://www.fig.sh/install.html)

## Installation sur Ubuntu 12.04

Il est nécessaire d'installer l'installeur de modules python.
Par chance, il est disponible dans le gestionnaire de paquet du sytème.

```bash
sudo aptitude install -y python-pip
````

Il ne reste plus que l'installation de `fig` à proprement parler.

```bash
sudo pip install -U fig
````

## Exemples de fichier de configuration

* [http://www.syncano.com/docker-workflow-fig-sh/](http://www.syncano.com/docker-workflow-fig-sh/)

```yaml
postgres:
    image: paintedfox/postgresql
    environment:
        - USER=root
        - PASS=awesome_pass
        - DB=my_db
    ports:
        - "5432"
    volumes:
        - /var/docker/postgresql:data
redis:
    image: dockerfile/redis
    volumes:
        - /var/docker/redis:data
    ports:
        - "6379"
rabbit:
    image: tutum/rabbitmq
    volumes:
        - /var/docker/rabbit:data
    environment:
        - RABBITMQ_PASS=awesome_pass
    ports:
        - "5672"
        - "15672"
web:
    build: .
    ports:
        - "8000:8000"
    links:
        - postgres:postgres
        - redis:redis
        - rabbit:rabbit
    volumes:
        - .:/home/my/app
    environment:
        - INSTANCE_TYPE=web-server
worker:
    build: .
    links:
        - postgres:postgres
        - redis:redis
        - rabbit:rabbit
    volumes:
        - .:/home/my/app
    environment:
        - INSTANCE_TYPE=worker
```

Les containers se lancent simplement par 

```bash
fig up
```

Pour avoir des informations sur le status des containers

```bash
fig ps
```
