---
layout: post
title: "Le DNS expliqué avec le DNS"
date: 2015-04-02  10:01:000 +0200
comments: false
tags: [dns]
---


# Le DNS expliqué avec le DNS

## Mékeskidi ?

Commande à lancer dans une console unix.
Le logiciel dig doit être installé

```bash
$ dig @ns1.statdns.com ascii.statdns.org naptr +short
```

réponse :

```
100 10 "" "              Local Host                        |  Foreign    " "" .
110 10 "" "                                                |             " "" .
120 10 "" " +---------+               +----------+         |  +--------+ " "" .
130 10 "" " |         | user queries  |          |queries  |  |        | " "" .
140 10 "" " |  User   |-------------->|          |---------|->|Foreign | " "" .
150 10 "" " | Program |               | Resolver |         |  |  Name  | " "" .
160 10 "" " |         |<--------------|          |<--------|--| Server | " "" .
170 10 "" " |         | user responses|          |responses|  |        | " "" .
180 10 "" " +---------+               +----------+         |  +--------+ " "" .
190 10 "" "                             |     A            |             " "" .
200 10 "" "             cache additions |     | references |             " "" .
210 10 "" "                             V     |            |             " "" .
220 10 "" "                           +----------+         |             " "" .
230 10 "" "                           |  cache   |         |             " "" .
240 10 "" "                           +----------+         |             " "" .

```

## Mais encore ?

### Que se passe-t-il ?

La commande `dig` est appelée avec plusieurs paramètres :

* `@ns1.statdns.com` : indique quel résolveur utiliser pour répondre à la question posée
* `ascii.statdns.org` : indique quel est le nom de dommaine de la question
* `naptr`  : indique le type d'information souhaitée (ici du tetxe. Le DNS ne stocke pas que des adresses IP)
* `+short` : indique que l'on souhaite l'affichage minimal de dig = seulement la réponse à la question sans fioriture

### Que dit le schéma du résultat ?

Le schéma indique les différentes activités qui sont réalisées dans le cas d'une requete (query) dns posée par l'utilisteur (user).
En pratique il s'agit d'un programme sur l'ordinateur de l'utilisateur.

Le mécanisme de résolution des requetes distingue deux types de serveur DNS.

* les résolveurs d'un cotés, qui s'occupent de chercher la réponse à la question, quitte à poser la question à plusieurs (autres) serveurs.
* les serveurs faisant authorité, qui "détiennent la vérité" sur une ou plusieurs zones. Une zone est un ensemble d'enregistrements.

