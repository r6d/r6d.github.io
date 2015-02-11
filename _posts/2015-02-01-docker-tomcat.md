---
layout: post
title: "Tomcat et Docker"
date: 2015-02-01 16:58:000 +0100
comments: false
tags: [java, docker]
---

# Déploiement rapide de serveur Tomcat avec docker

[Tomcat](http://tomcat.apache.org/) :

* un serveur d'application [Java](http://fr.wikipedia.org/wiki/Java_%28langage%29)
* fait partie des implémentations les plus connues & déployées

Notes :

* les commandes données ici n'ont pas vocation à conserver les données
* dès que les commandes sont terminées, les données produites dans le conteneur sont perdues.

## Instructions de lancement simple

D'après l'[image officielle du registre](https://registry.hub.docker.com/_/tomcat/) :

```bash
$ docker run --rm -it tomcat:8.0
```

Le port d'écoute par défaut est `8080`.

Une [image alternative](https://registry.hub.docker.com/u/tutum/tomcat/),[le github](https://github.com/tutumcloud/tutum-docker-tomcat) propose de définir un mot de passe pour l'utilisateur de l'application de gestion :

```bash
$ docker run --rm -it -p 8080:8080 -e TOMCAT_PASS="mypass" tutum/tomcat
```

L'application de gestion devient disponible à l'adresse :

[http://127.0.0.1:8080/manager/](http://127.0.0.1:8080/manager/)


L'utilisateur est `admin` et le mot de passe celui indiqué dans la chaine de lancement.

## Lancement de Tomcat 8 avec un jre 8

[image docker](https://registry.hub.docker.com/u/jpierre03/tomcat/), [le github](https://github.com/jpierre03/docker-tomcat)

```bash
$ docker run --rm -it -p 8080:8080 -e TOMCAT_PASS="mypass" jpierre03/tomcat
```

Le manager est disponible en tant que `admin` avec le mot de passe indiqué en paramètre

[http://127.0.0.1:8080/manager/](http://127.0.0.1:8080/manager/)

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
