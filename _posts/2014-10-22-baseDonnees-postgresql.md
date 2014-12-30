---
layout: post
title: "Base de données - PostgreSQL"
date: 2014-10-22 16:25:06 -0700
comments: false
---

# PostgreSQL

* [http://cheat.errtheblog.com/s/postgresql/](http://cheat.errtheblog.com/s/postgresql/)

## Peupler des tables

* Peupler une table rapidement avec des données aléatoires :

```sql
INSERT INTO Log(level, message)
SELECT 'level2' as level, md5(random()::text) AS descr
	FROM (SELECT * FROM generate_series(1,10*1000*1000) AS id) AS x;
```

## Création de base

* Create the filesystem

	```bash		
	$ export PGROOT="/var/lib/postgres"
	$ mkdir -p $PGROOT/data && chown postgres.postgres $PGROOT/data
	$ su - postgres -c "/usr/bin/initdb -D $PGROOT/data"
	```
* Make it UTF8 by default

	```bash
	$ su - postgres -c "/usr/bin/initdb -E utf8 --locale=en_US.UTF-8 $PGROOT/data"
	```
* Create Databases

	```bash
	createdb -O owner -T some_template database_name
	```
	
	* By default, PostgreSQL listens on TCP port 5432.

## Export de base
* Dump all databases

	```bash
	pg_dumpall --clean > databases.sql
	```
* Dump a database with compression (-Fc)

	```bash
	pg_dump -Fc --file=database.sql --clean database
	```

* Dump a table

	```bash
	pg_dump [-d database] [--schema schema] -t table
	```
* Dump a table definition (no data)

	```bash
	pg_dump -s [-d database] [--schema schema] -t table
	```

## Restauration de base
* Restore a database from a dump file

	```bash
	pg_dump -Ft [-h host] [-p port] [-U username[  [--schema=schema] -F c -b -v -f 	<path_to_dump_file> <db_name>
	```
	* -p, –port=PORT database server port number
	* -i, –ignore-version proceed even when server version mismatches
	* -h, –host=HOSTNAME database server host or socket directory
	* -U, –username=NAME connect as specified database user
	* -W, –password force password prompt (should happen automatically)
	* -d, –dbname=NAME connect to database name
	* -v, –verbose verbose mode
	* -F, –format=c|t|p output file format (custom, tar, plain text)
	* -c, –clean clean (drop) schema prior to create
	* -b, –blobs include large objects in dump
	* -v, –verbose verbose mode
	* -f, –file=FILENAME output file name
* Restore a database

	```bash
	pg_restore -Fc database.sql
	pg_restore [-h host] [-p port] [-U user] [--schema=schema] -d database -v -c <path_to_dump_file>
	```
	* -p, --port=PORT database server port number
	* -i, --ignore-version proceed even when server version mismatches
	* -h, --host=HOSTNAME database server host or socket directory
	* -U, --username=NAME connect as specified database user
	* -W, --password force password prompt (should happen automatically)
	* -d, --dbname=NAME connect to database name
	* -v, --verbose verbose mode
	* -c, --clean Clean (drop) database objects before recreating them
* Reset password of postgres user

	```bash
	# su postgres
	# psql -d template1
	template1=# ALTER USER postgres WITH PASSWORD '${POSTGRESQL_POSTGRES_PASSWORD}';
	```

## psql

* Psql - show a list of databases
	* => \\l
	* Lowercase L, not the number 1
* Psql - show all users
	* => select * from pg_user;
* Psql - show all tables (including system tables)
	* => `select * from pg_tables;`{.sql}
* Psql - show tables in the current context (database/schema)
	* => \\d
* Psql - change current database
	* => \\c database;
* Psql - show all schemas in the current database
	* => \\dn
* Psql - Grant permissions on a schema to a user
	* => `GRANT ALL ON myschema TO user;`{.sql}
* Psql - quit psql
	* => \\q
* Psql - show help
	* => \\?
* Psql - copy a table to a tab delimeted file
	* => `COPY table TO 'table.txt';`{.sql}
* Psql - load a table from a tab delimeted file
	* => `COPY table FROM 'table.txt';`{.sql}
* Psql - show permissions on database objects
	* => \\z [object]
	* r -- `SELECT`{.sql} ("read")
	* w -- `UPDATE`{.sql} ("write")
	* a -- `INSERT`{.sql} ("append")
	* d -- `DELETE`{.sql}
	* R -- `RULE`{.sql}
	* x -- `REFERENCES`{.sql} (foreign keys)
	* t -- `TRIGGER`{.sql}
	* X -- `EXECUTE`{.sql}
	* U -- `USAGE`{.sql}
	* C -- `CREATE`{.sql}
	* T -- `TEMPORARY`{.sql}
	* arwdRxt -- `ALL PRIVILEGES`{.sql} (for tables)
	* -- grant option for preceding privilege
	* /yyyy -- user who granted this privilege
* Run the vacuum utility
	* => `vacuumdb --verbose --analyze --all`{.bash}
	* Note:
		* vacuum reclaims space from deleted records and updates indexes.
		* It should be set up in cron.
		* Newer versions of postgresql may run vacuum automatically.
		* Increase perfomance with shared memory

## PostgreSQL Examples
* Adding new user called BRIAN:

	```bash
	$ sudo su - postgres
	$ createuser --createdb --username postgres --no-createrole \\
	 		--pwprompt BRIAN
		Enter password for new role:
		Enter it again:
		Shall the new role be a superuser? (y/n) n
	$ exit
	```

* ALTER TABLE
	* Add a unique constraint to the email column in the customer table
	
	```sql
	ALTER TABLE customer ADD CONSTRAINT customer_email_key UNIQUE (email);
	```

## PostgreSQL-Snippet

### Créer un utilisateur et lui donner les droits sur une DB

```bash
su - postgres
```
```sql
CREATE USER tom WITH PASSWORD 'myPassword';
CREATE DATABASE jerry;
GRANT ALL PRIVILEGES ON DATABASE jerry to tom;
\q
```

### Changer le propriétaire d'une base

```sql
ALTER TABLE climate.measurement OWNER TO postgres;
```
	
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
