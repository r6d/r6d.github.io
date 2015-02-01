---
layout: post
title: "Tomcat et Docker"
date: 2015-02-01 16:58:000 +0100
comments: false
tags: [tomcat, java, docker]
---

# Déploiement rapide d'un serveur d'application Java. Tomcat + docker

[Tomcat](http://tomcat.apache.org/) :

* un serveur d'application java
* fait partie des implémentations les plus connues & déployées

Notes :

* les commandes données ici n'ont pas vocation à conserver les données
* dès que les commandes sont terminées, les données produites dans le conteneur sont perdues.

## Instructions de lancement simple

D'après l'[image officielle du registre](https://registry.hub.docker.com/_/tomcat/) :

```bash
docker run -it --rm tomcat:8.0
```

Le port d'écoute par défaut est `8080`.

Une [image alternative](https://registry.hub.docker.com/u/tutum/tomcat/) propose de définir un mot de passe pour l'utilisateur de l'application de gestion :

```bash
docker run -it --rm -p 8080:8080 -e TOMCAT_PASS="mypass" tutum/tomcat
```

L'application de gestion devient disponible à l'adresse :

```
http://127.0.0.1:8080/manager/
```

L'utilisateur est `admin` et le mot de passe celui indiqué dans la chaine de lancement.