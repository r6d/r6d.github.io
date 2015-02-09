# Partage de fichiers

## AFP, partage de fichier apple

Sous Ubuntu le paquet correspondant est _netatalk_

* bon lien, fonctionne en un tour de main : [[http://d43.me/blog/1660/concisest-guide-to-setting-up-time-machine-server-on-ubuntu-server-12-04/](http://d43.me/blog/1660/concisest-guide-to-setting-up-time-machine-server-on-ubuntu-server-12-04/)]

* ancien lien : [[http://web.archive.org/web/20100722110311/http://www.kremalicious.com/2008/06/ubuntu-as-mac-file-server-and-time-machine-volume](http://web.archive.org/web/20100722110311/http://www.kremalicious.com/2008/06/ubuntu-as-mac-file-server-and-time-machine-volume)]

# Système de fichier / filesystem

## Informations sur les fichiers

* Avoir le numéro d'inode

```bash
ls -il
````

* Avoir des infos sur un fichier (dont inode) :

```bash
stat file
````

## Changer l'ordre des champs d'affichage de ls

```bash
ls -la \
	|awk '{print $5,"-----",$7,"---",$8,"-----",$6}' \
	|sort -n
```

## Tris des fichiers/répertoires par taille croissante

* version 1

```bash
du -s * | awk '{print $1,"-----",$1/(1024*1024),"Go","-----",$2}' | sort -n
```

* version 2

```bash
#!/bin/sh

du -s * | awk '{{printf "%8s --- %8s Go --- ",$1,$1/(1024*1024)}{for (i=2;i<=NF;i++) { printf "%s ",$i }}{printf "\n"}}' | sort -n
```

## Trouver les 50 plus gros fichiers dans une arborescence

* version 1

```bash
find / -type f ! -regex "^/[proc\|dev\|sys]*/.*" -printf "%s %p\n" \
	|sort -rnk1 \
	|head -n50 \
	|awk '{print $1/1048576 "MB" " " $2}'
```

* version 2

```bash
du -s * | awk '{
	#{printf "-|"}
	{printf "%8s --- %8s Go --- ",$1,$1/(1024*1024)}
	#{printf "|-|"}
	{for (i=2;i<=NF;i++) { printf "%s ",$i }}
	#{printf "|-\n"}
	{printf "\n"}
}' | sort -n
``

* version 3 (condensé de la v2)

```bash
du -s * \
	| awk '{{printf "%8s --- %8s Go --- ",$1,$1/(1024*1024)}{for (i=2;i<=NF;i++) { printf "%s ",$i }}{printf "\n"}}' \
	| sort -n
```

# Encodage

## Conversion d'encodage de fichiers en masse

* utilisation de iconv

```bash
#!/bin/sh

# permet la passage de paramère par la console, lorsque ce script est enregistré dans un fichier
#folder=$1
folder=`pwd`

for i in $folder/*
do
	iconv --from-code UTF8 --to-code ISO-8859-15 "$i" -o "${i}_iso885915" --silent
	# pour remplacer la version utf8 par la version iso, décommente la ligne suivante
	#mv "${i}_iso885915" "$i"
done
```
