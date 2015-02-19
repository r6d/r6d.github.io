---
layout: post
title: "FAQ développement avec microntrolleur"
date: 2015-02-19 17:30:000 +0100
comments: false
tags: [faq, µC]
---

# FAQ, développement avec microntrolleur

Problèmes et difficultés rencontrées

## Comment démarrer ?

Suggestion : 

* créer un dépôt git pour l'application à développer
* commencer la prise en main à partir d'un code d'exemple
* compiler le programme avec un Makefile
* déployer sur la carte
* vérifier que le comportement de la carte correspond bien au programme chargé

Si tout est bon, continuer :)

* modifier le fichier source en y ajoutant une erreur volontairement
* compiler
* le compilateur doit râler, sinon c'est que le Makefile est incorrect ou mauvais fichier modifié

* ajouter les fonctions correspondantes au comportement souhaité
* intégrer les fonctions avec le code existant
* compiler, déployer sur la carte
* vérifier le comportement
* si pas bon, continuer de développer
* si bon, commencer sérieusement l'étape de nettoyage du code
	* enlever le code mort et/ou inutile (l'outil de gestion de version est là au cas où)
	* nommer et renommer les variables pour qu'elles aient des significations explicites ET en anglais
	* extraire des fonctions faisant peu de choses, avec des noms explicite.

		Plus une action est complexe, plus elle doit être découpée en fonctions

	* ajouter les assertions sur les invariants
	* ajouter les pré-conditions
	* ajouter les post-vérifications

## Quoi vérifier lors des commandes & demandes d'achat de matériel ?

* le processeur sur la carte est le bon
* le moyen d'alimenter la carte
	* vérifier qu'un moyen sera dispo dès la réception de la carte
	* à défaut, s'en procurer une
* le moyen de programmer la carte
	* vérifier que la connectique est déjà en stock
	* à défaut, se procurer le composant

## Comment utiliser le port série sous GNU/Linux ?

* les ports séries apparaissent comme des fichiers
* ils apparaissent sous la forme `/dev/tty*`
* lorsque l'adaptateur est USB, `/dev/ttyUSBx` avec `x` le numéro de port sur l'adaptateur

En plus de cela, il faut que l'utilisateur soit membre du groupe _dialout_.

```bash
sudo adduser <username> dialout
```

Il est possible d'écrire "toto" dans le port série :

```bash
echo "toto" >> /dev/ttyUSB0
```

Il est d'une façon similaire possible de lire un port série :

```bash
cat /dev/ttyUSB0
```

ou 

```
tail -f /dev/ttyUSB0
```bash

ATTENTION : le port doit être déjà configuré par rapport au matériel à utiliser, sinon ça ne fonctionne pas comme prévu
