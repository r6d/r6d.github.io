---
layout: post
title: "Outils pour débugger bind9, le serveur DNS"
date: 2015-02-09 18:58:000 +0100
comments: false
tags: [dns, bind, résolveur, serveur faisant authorité]
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



