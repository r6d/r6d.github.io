---
layout: post
title: "Outils pour débugger bind9, le serveur DNS"
date: 2015-02-09 18:58:000 +0100
comments: false
tags: [dns, reseau]
---

# Déboggage de service DNS fourni par bind9

## Note

Il n'est pas conseillé d'appliquer les commandes indiquées ici à un serveur hébergeant un nombre de zones important et/ou fortement utilisé.

En effet, dans le cadre d'une configuration simple, le temps de rechargement de bind est marginal.
Cette affirmation est rapidement fausse lorsque la configuration du serveur devient importante.

## Préliminaires

[bind](https://www.isc.org/downloads/bind/) est un logicel assurant plusieurs services clef d'une infrastructure [DNS](http://fr.wikipedia.org/wiki/Domain_Name_System).
A savoir :

* serveur faisant authorité = indique la vérité sur le contenu d'une zone désignée par un nom de domaine
* résolveur, serveur récursif = parcours l'arborescence du DNS pour répondre à une demande

Le premier comportement sert à mettre à disposition une `zone`.
Cela correspond à l'ensemble des informations qui peuvent être répondues par le serveur.

le second (résolveur) permet d'interroger les serveurs nécessaires à l'obtention d'une demande par l'utilisateur.
C'est ce service qui est utilisé sur le poste de l'utilisateur, ou plus courament chez le FAI (Fournisseur d'Accès à Internet) de celui-ci, lorsqu'il cherche à contacter _http://www.google.co.uk_, _http://www.facebook.com_, _http://www.free.fr_ et autre site.

  * Le navigateur web, demande au résolveur de résoudre (de transformer la chaine de texte en adresse IP) le nom de machine (_www.google.co.uk_, _www.facebook.com_, _www.free.fr_) afin de pouvoir établir la connexion.
  * le résolveur utilise son cache (une technique pour conserver en local des informations) pour répondre.
    En cas d'absence d'information dans le cache (première demande ou valeur expirée), le résolveur parcours l'arborescence du DNS  en commençant par la racine `.`
    Puis dans les exemples : `com.`, `fr.`et `uk.` et ainsi de suite jusqu'à obtenir une réponse (positive ou négative).

## Problématique

Lorsque l'on héberge sa propre zone, typiquement pour servir son nom de domaine, il arrive que _ça marche pas_ .

Le processus de débug peut être fastidieux et quelques outils sont fournis avec `bind` pour faciliter la correction des erreur.

* un outil de vérification de la configuration : `named-checkconf`
* un outil de vérification des zones : `named-checkzone`
* un outil de gestion du serveur bind : `rndc`

## Serveur faisant authorité, commandes pour le déboggage

Avant de changer la configuration il est conseillé de réaliser une sauvegarde des fichiers de configuration.
Par exemple avec [GIT](http://git-scm.com/book/fr/v1) avec un `commit`.

Pour la suite, considéront :

* que le système est un Ubuntu 14.04
* bind9 est installé par le gestionnaire de paquet
* la configuration est dans le répertoire par défaut : `/etc/bind`
* le nom de domaine servi est `example.net`, contenu dans le fichier de zone `example.net.zone`

### Vérification de la configuration du serveur

Déplacement dans le bon répertoire et vérification du contenu :

```bash
$ cd /etc/bind
$ ls
 bind.keys
 db.0
 db.127
 db.255
 db.empty
 db.local
 db.root
 example.net.zone
 named.conf
 named.conf.default-zones
 named.conf.local
 named.conf.options
 rndc.key
 zones.rfc1918
```

On vérifie la configuration du serveur avec l'outil adapté :

```bash
$ named-checkconf -t named.conf
```

Si tout va bien, rien n'est indiqué.

En cas d'erreur (oubli d'un `;` sur la ligne 13) :

```bash
$ named-checkconf -j named.conf
named.conf:13: missing ';' before 'logging'
```

### Vérification de la configuration de la zone

On se place dans le même répertoire que le fichier de zone.
Ici, `/etc/bind`.

```bash
$ named-checkzone example.net example.net.zone 
example.net.zone:2: no TTL specified; using SOA MINTTL instead
zone example.net/IN: sub.example.net/NS 'ns2.example.net' has no address records (A or AAAA)
zone example.net/IN: loaded serial 2014122301
OK
```

On peut constater que la zone est valide pour l'outil de vérification du fait de la présence du `OK` à la fin.
C'est à dire qu'il n'y a pas d'erreur de syntaxe dans le fichier.

Par contre il y a deux erreurs de contenu qu'il faut corriger.

* à la ligne 2, il manque la valeur du TTL
* l'entrée `sub.example.net` utilise un serveur de nom, champ `NS` qui n'a pas d'adresse connue (ni IPv4 `A`, ni IPv6 `AAAA`)

A noter que l'utilisation de `rndc` ne pose pas de problème sur cette zone (pas de vérification du contenu):

```bash
$ rndc reload example.net
```

### Vérification en tant qu'utilisateur

L'outil adapté pour vérifier les réponses d'un serveur DNS, que ce soit bind ou un autre d'ailleur s'appelle `dig` :

```bash
$ dig example.net

; <<>> DiG 9.8.1-P1 <<>> example.net
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47969
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;example.net.                   IN      A

;; ANSWER SECTION:
example.net.            86389   IN      A       93.184.216.34

;; Query time: 2 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: Mon Feb  9 19:49:06 2015
;; MSG SIZE  rcvd: 45
```

Cette réponse :

* indique que tout va bien : `NOERROR`.
  Un `SERVFAIL` est signe d'une erreur importante qui devrait être détectée avec les outils précédents.
* la réponse à la question, section `ANSWER` donne l'adresse IPv4, `A`  

## Résolveur, commande usuelles de déboggage

Référence : [bortzmeyer.org](http://www.bortzmeyer.org/vider-cache-resolveur.html)

* vider le cache d'une zone

 ```bash
 $ rndc flushname example.net
 ```

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
