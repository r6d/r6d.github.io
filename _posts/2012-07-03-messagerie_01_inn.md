---
layout: post
title: "Messagerie - INN"
date: 2012-07-03 12:56:32 +0200
comments: false
---

# Messagerie - INN

* rename pour conserver le dernier extract des news

	```bash
	mv nouveau nouveau.old
	```

* récupère les derniers messages du serveur

	```bash
	suck news.free.fr -c -n -br nouveau
	```

* transfère les news à `INN`

	```bash
	rmail nouveau
	```

* ajoute le groupe nl.telecom

	```bash
	/usr/sbin/ctlinnd newgroup nl.telecom
	```
