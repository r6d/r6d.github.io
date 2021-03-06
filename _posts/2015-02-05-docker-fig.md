---
layout: post
title: "Fig et Docker"
date: 2015-02-05 16:58:000 +0100
comments: false
tags: [fig, docker, docker-compose]
---

# Lancer plusieurs applications docker-isées avec fig

Note 2021-03-29 : Fig est obsolète depuis un moment, maintenant on appelle ça "docker-compose".

* [instructions officielles d'installation](http://www.fig.sh/install.html)

## Installation sur Ubuntu 12.04

Il est nécessaire d'installer l'installeur de modules python.
Par chance, il est disponible dans le gestionnaire de paquet du sytème.

```bash
$ sudo aptitude install -y python-pip
````

Il ne reste plus que l'installation de `fig` à proprement parler.

```bash
$ sudo pip install -U fig
````

## Exemple de fichier de configuration

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
$ fig up
```

Pour avoir des informations sur le status des containers

```bash
$ fig ps
```

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
