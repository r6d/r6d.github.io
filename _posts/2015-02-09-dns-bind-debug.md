---
layout: post
title: "Outils pour débugger bind9, le serveur DNS"
date: 2015-02-09 18:58:000 +0100
comments: false
tags: [dns, bind, résolveur, serveur faisant authorité]
---

# Déboggage de service DNS fourni par bind9

## Préliminaires

[bind](https://www.isc.org/downloads/bind/) est un logicel assurant plusieurs services clef d'une infrastructure [DNS](http://fr.wikipedia.org/wiki/Domain_Name_System).
A savoir :

* serveur faisant authorité = indique la vérité sur le contenu d'une zone désignée par un nom de domaine
* résolveur, serveur récursif = parcours l'arborescence du DNS pour répondre à une demande

Le 
