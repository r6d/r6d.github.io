---
layout: post
title: "Elasticsearch et Docker"
date: 2015-01-15 23:21:000 +0200
comments: false
tags: [elasticsearch, docker]
---

# Utilisation d'Elasticsearch à grand renfort de docker

## Maiskeskidit ?

Il s'agit dans ce post d'exposer quelques commandes permettant de prototyper avec elasticsearch.

Ces commandes n'ont pas vocation à conserver les données.
Dès qu'elles sont terminées, les données sont perdues.

## Lancement de plusieurs instances d'elasticsearch

[Elasticsearch.org](http://www.elasticsearch.org) ou [Elasticsearch, la société](http://www.elasticsearch.com) propose un moteur de recherche gratuit, libre (open source avec autorisation de modification et de partage du code), distribué et surtout : qui marche facilement.

Voici comment lancer rapidement un cluster de 5 instances, on parle de `noeud`ou de `node` en utilisant [docker](http://www.docker.io).

```bash
$ docker run --rm -it -p 19200:9200 -p 19300:9300 dockerfile/elasticsearch 
$ docker run --rm -it -p 29200:9200 -p 29300:9300 dockerfile/elasticsearch 
$ docker run --rm -it -p 39200:9200 -p 39300:9300 dockerfile/elasticsearch
$ docker run --rm -it -p 49200:9200 -p 49300:9300 dockerfile/elasticsearch
$ docker run --rm -it -p 59200:9200 -p 59300:9300 dockerfile/elasticsearch
```

L'exécution de ces commandes dans des terminaux différents permet d'obtenir une réponse pour chacune des url :

* [node 1, http://localhost:19200](http://localhost:19200)
* [node 2, http://localhost:29200](http://localhost:29200)
* [node 3, http://localhost:39200](http://localhost:39200)
* [node 4, http://localhost:49200](http://localhost:49200)
* [node 5, http://localhost:59200](http://localhost:59200)

Au besoin, il est possible d'accéder directement avec l'adresse IP de la machine à la place de `localhost`.

## Duplication de données d'un serveur à un autre

Lors des test, il est également utile d'avoir des données à charger rapidement dans elasticsearch.

Options : 

1. charger un jeux de données tout prêt, par exemple [shakespeare.json](http://www.elasticsearch.org/guide/en/kibana/current/using-kibana-for-the-first-time.html)

	En utilisant `curl` :
	
	```
	$ curl -XPUT localhost:9200/_bulk --data-binary @shakespeare.json
	```
1. copier les données d'une instance elasticsearch déjà configurées `=`créer un clone partiel ou intégral.

	En utilisant `elasticdump`

	Pour charger seulement un index d'une instance sur le port standard. Ici l'index s'appelle `logstash-2014.12.19.15` :
 
	````bash
	$ docker run --rm -t sherzberg/elasticdump --input=http://localhost:9200/logstash-2014.12.19.15 --output=http://localhost:29200/logstash-2014.12.19.15
	```

	Pour charger tous les index d'une instance sur le port standard.

	```bash
	$ docker run --rm -t sherzberg/elasticdump --all=true --bulk=true --input=http://localhost:9200 --output=http://localhost:29200
	```


### Kibana 4

[https://github.com/bobrik/docker-kibana4](https://github.com/bobrik/docker-kibana4)


## Instance ES avec monitoring simple (head)

```bash
$ docker run --rm -it --name es -p 6520:9200 -p 6530:9300 jamescarr/elasticsearch-head
```

Disponible à [http://localhost:6520/_plugin/head/](http://localhost:6520/_plugin/head/)
