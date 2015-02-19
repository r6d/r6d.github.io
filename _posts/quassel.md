---
layout: post
title: "Trucs et astuce Ms Project 2013"
date: 2015-02-19 15:14:000 +0100
comments: false
tags: [irc, sql]
---

# Manipulation de données d'un historique IRC avec Quassel et PostgreSQL

## Contexte

### IRC

[IRC](http://fr.wikipedia.org/wiki/Internet_Relay_Chat) est un ancien protocole de chat, qui fonctionne, qui ne dépend pas des GAFA.

A la différence de certains systèmes de chat, il est possible de choisir un réseau IRC en sélectionnant un serveur IRC et ainsi accéder à des salons de discussion différents.

IRC est un système pour lequel la communication est par salon de discussion.
C'est à dire qu'il y a potentiellement plusieurs personnes en même temps.

La communication entre deux personnes est possible.

### Quassel

[Quassel](http://quassel-irc.org/) est un client IRC qui peut fonctionner de plusieurs façons différentes :

* mode client simple
* mode client-serveur

En mode client simple :
* quassel se connecte au serveur IRC comme les autres clients IRC ([xchat](http://xchat.org/), [mibbit](https://www.mibbit.com/))

* quassel stocke l'historique des cannaux connectés en local sur le PC

En mode client-serveur :
* quassel-client se connecte au quassel-serveur
* quassel-serveur se connecte au serveur IRC
* quassel-serveur stocke l'historique des cannaux connectés dans une base de données
([sqlite](http://www.sqlite.org/) par défaut, [MySQL](http://www.mysql.fr/) et [PostgreSQL](http://www.postgresqlfr.org/) au choix)

## Besoin

Après quelques mois de connexion continue à des cannaux IRC bien actifs, la base de donnée de stockage de l'historique est devenue imposante (= prend trops de place pour l'utilisation réelle de l'historique).
Il est donc temps de faire un peu de nettoyage.

