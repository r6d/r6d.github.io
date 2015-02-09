---
layout: post
title: "Base de données - FoxPro -> PostgreSQL"
date: 2012-10-22 16:25:06 -0700
comments: false
tags: [database, foxpro, postgresql]
---

# FoxPro -> PostgreSQL

* Import de fichier `.dbf` dans PostgreSQL.

Les fichier `.dbf` contiennent de simples tables (1 fichier = 1 table).

Cette méthode ne s'applique pas à la conversion de base fox pro gérant les relations.

```bash
$ find . -type f -name "*.dbf" -exec \
	bash -c 'pgdbf "{}" \
		| iconv -c -f UTF-8 -t UTF-8 \
		|psql -d <user>' \;
```
