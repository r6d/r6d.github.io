---
layout: post
title: "Messagerie - UUCP"
date: 2012-07-03 12:56:32 +0200
comments: false
---

# Messagerie - UUCP

## Envois de fichier

* envoyer une arborescence fichier en uucp (modèle)

	```bash
	for i in `find . -type f` ; do uucp "$i" 'xray!~/'$i''; done
	```

* envois de fichiers (arborescence) vers 'machine'

	```bash
	uucp-machine() {
		echo $1
		for i in `find "$1" -type f` ; do uucp "$i" 'machine!~/'$i''; done
	}
	```

* envois de fichiers (arborescence) vers cube en passant par machine

	```bash
	uucp-cube() {
		IFS_OLD=$IFS
		IFS=$'\x0a'
		for i in `find "$1" -type f` ; do uucp "$i" 'machine!cube!/var/spool/	uucppublic/'"$i"; done
		IFS=$IFS_OLD
	}
	```

## Statistiques

* statistiques sur le daemon uucp

	```bash
	/usr/sbin/uurate -a
	```

* état du daemon

	```bash
	uustsat -m
	```
