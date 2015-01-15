---
layout: post
title: "Base de données - Sqlite"
date: 2012-10-22 16:25:06 -0700
comments: false
tags: [database, sqlite]
---
	
# Sqlite

## sqlite & firefox

* Extraire les URL's de la bdd de firefox

	```bash
	sqlite3 places.sqlite "SELECT * FROM moz_places" \
			| awk -F '|' '{print "\033[4m" $1 "\033[m) " $2}'
	```

	le fichier en question peut se trouver à :

	```bash
	$HOME/.mozilla/firefox/<??>.default
	```

## Exemple de script

Script qui crée une base `dbname.db`, avec une table `data`, qui insère plusieurs lignes de données.
Et qui affiche des données à partir d'une requête.

```bash
	#!/bin/bash

	# Defining my databse first table
	STRUCTURE="CREATE TABLE data (id INTEGER PRIMARY KEY,name TEXT,value TEXT);";

	# Creating an Empty db file and filling it with my structure
	cat /dev/null > dbname.db
	echo $STRUCTURE > /tmp/tmpstructure
	sqlite3 dbname.db < /tmp/tmpstructure;
	rm -f /tmp/tmpstructure;

	# Inserting some data into my structure
	sqlite3 dbname.db "INSERT INTO data (name,value) VALUES ('MyName','MyValue')";
	sqlite3 dbname.db "INSERT INTO data (name,value) VALUES
	('MyOtherName','MyOtherValue')";

	# Getting my data
	LIST=`sqlite3 dbname.db "SELECT * FROM data WHERE 1"`;

	# For each row
	for ROW in $LIST; do
		# Parsing data (sqlite3 returns a pipe separated string)
		Id=`echo $ROW | awk '{split($0,a,"|"); print a[1]}'`
		Name=`echo $ROW | awk '{split($0,a,"|"); print a[2]}'`
		Value=`echo $ROW | awk '{split($0,a,"|"); print a[3]}'`

		# Printing my data
		echo -e "\e[4m$Id\e[m) "$Name" -> "$Value;
	done
```
