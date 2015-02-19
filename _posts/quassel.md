---
layout: post
title: "Trucs et astuce Ms Project 2013"
date: 2015-02-19 15:14:000 +0100
comments: false
tags: [irc, sql]
---

# Manipulation de données d'un historique IRC avec Quassel et PostgreSQL


## Contexte

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

Après quelques mois de connexion continue à des cannaux IRC bien actifs, la base de donnée stockan

