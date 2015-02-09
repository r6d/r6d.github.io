---
layout: post
title: "Messagerie - INN"
date: 2012-07-03 12:56:32 +0200
comments: false
---

# Messagerie - Le serveur de nouvelles (news) INN

* [INN, InterNetNews sur Wikipedia](http://fr.wikipedia.org/wiki/InterNetNews),
* [installation d'après un article sur linux-france.org](http://www.linux-france.org/article/usenet/jaco/indexs08.html),

* rename pour conserver le dernier extract des news

	```bash
	$ mv nouveau nouveau.old
	```

* récupère les derniers messages du serveur

	```bash
	$ suck news.free.fr -c -n -br nouveau
	```

* transfère les news à `INN`

	```bash
	$ rmail nouveau
	```

* ajoute le groupe nl.telecom

	```bash
	$ /usr/sbin/ctlinnd newgroup nl.telecom
	```
