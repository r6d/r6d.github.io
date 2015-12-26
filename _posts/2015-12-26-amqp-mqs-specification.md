---
layout: post
title: "Architecture Orientée Message, Spécification"
date: 2015-12-26 20:45:000 +0100
comments: false
tags: [amqp, rabbitmq, specification]
---

# Spécification d'une architecture de services orientée messages

## Introduction

Ce document a pour vocation de décrire une architecture de principe avec les besoins associés.

Cette architecture répond à un besoin de remise de courrier : permettre la distribution de messages de producteurs vers un ou plusieurs consommateurs.

## Expression des besoins
 
### Story Application

En tant qu' administrateur système  ayant :

* des lots de traitements à faire réaliser par un programme sur plusieurs machines pour améliorer les performances (répartition de charge)
* des machines devant être non-connectée régulièrement
* des tâches dont la durée de traitement est plus grande que 10 s

J'aimerais :

* faciliter la supervision des tâches (restantes à exécuter, en cours, ...)
* ne pas perdre une tâche non finie en cas de crash du worker + redistribution automatique sur un autre worker
* pouvoir ajouter/supprimer des workers facilement, même s'ils sont sur plusieurs machines. Les tâches sont équitablement réparties entre les workers.

La solution actuelle utilise différents composants :

* des fichiers sur disque contenant les tâches à exécuter + des scripts lancés à la main pour consommer ces fichiers
* des commandes transférées en UUCP. Les workers (machines qui exécutent les commandes) récupèrent le travail avec `cron`

### Story Logs

En tant qu' administrateur système  ayant :

* en gestions plusieurs services (web , mail, dns, base de données, ...) produisant des traces d'activité (log),
* plusieurs sources (assimilées à des clients) produisant des logs

J'aimerais :

* centraliser les flux de logs
* pouvoir orienter les flux vers différentes destination (poubelle, archivage, notification d'erreur, ...) selon des marquages sur les messages (clef de routage)

### Business

En tant que représentant du métier X, j'aimerais :

* avoir une configuration simple sur service de messagerie (=1 en entrée, 1 en sortie de l'application)
* ne pas m'occuper de la configuration du serveur de messagerie
* avoir des garanties de remise de messages
* avoir un suivi (graphe) des volumétries de messages
* pouvoir tester deux (minimum) implémentations d'une application sur le même flux de message (1 en production et 1 en test)
* pouvoir publier/consommer ~5 k message par seconde
* pouvoir supprimer toutes les tâches en attentes d'une application

## Architecture

![schéma de principe](/assets/files/2015/12/mqs-principe.png)

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
