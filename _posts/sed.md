# Commande - Sed

# liens

	http://www.grymoire.com/Unix/Sed.html#uh-7
	http://sed.sourceforge.net/sed1line_fr.html

# Espacement de fichier

* espacer en double un fichier

		sed G
	
* espacer en double un fichier qui a déjà des lignes vides.
	* Le fichier de sortie n'aura jamais plus qu'une ligne vide entre les lignes de texte.

			sed 'G;G'

* défaire le double-espacement
	* (assumons les lignes paires comme étant toujours vides)

			sed 'n;d'

* espacer en triple un fichier

			sed 'G;G'

* insérer une ligne vide au-dessus de chaque ligne qui contient "regex"

			sed '/regex/{x;p;x;}'

* insérer une ligne vide sous chaque ligne qui contient l'expression régulière "regex"

			sed '/regex/G'

* insérer une ligne vide au-dessus et au-dessous de chaque ligne qui contient "regex"

			sed '/regex/{x;p;x;G;}'

# Numérotation

* numéroter chaque ligne du fichier (appuyé simplement à gauche).
	* L'utilisation d'une tabulation (voir la note sur '\t' à la fin de ce texte) au lieu d'un espace préservera les marges.

			sed = nomdefichier | sed 'N;s/\n/\t/'

* numéroter chaque ligne d'un fichier (numéro à gauche, appuyé à droite)

		sed = nomdefichier | sed 'N; s/^/     /; s/ *\(.\{6,\}\)\n/\1  /'

* numéroter chaque ligne d'un fichier, mais afficher le numéro de ligne seulement si la ligne n'est pas vide.

		sed '/./=' nomdefichier | sed '/./N; s/\n/ /'

* compter les lignes (émulation de "wc -l")

		sed -n '$='

# Conversion de texte et substitution (I)

* ENVIRONEMENT UNIX:  conversion des retour de chariot (CR/LF) au format Unix.
	* assume que toutes les lignes se terminent avec CR/LF

			sed 's/.$//'

	* sous bash/tcsh, enfoncer Ctrl-V puis Ctrl-M

			sed 's/^M$//'

	* fonctionne sous  ssed, gsed 3.02.80 ou plus récent

			sed 's/\x0D$//'

* ENVIRONEMENT UNIX:  conversion des retour de chariot UNIX (LF) au format DOS.
	* ligne de commande sous ksh

			sed "s/$/`echo -e \\\r`/"

	* ligne de commande sous bash

			sed 's/$'"/`echo \\\r`/"

	* ligne de commande sous zsh

			sed "s/$/`echo \\\r`/"

	* gsed 3.02.80 ou plus haut

			sed 's/$/\r/'

* ENVIRONMENT DOS: convertir les retour de chariot Unix  (LF) au format DOS.
	* méthode 1

			sed "s/$//"

	* méthode 2

			sed -n p

# Conversion de texte et substitution (II)

* ENVIRONMENT DOS: convertir les retour de chariot DOS (CR/LF) au format Unix.
	* Peut seulement être utilisé avec UnxUtils sed, version 4.0.7 ou plus récente.
	* La version UnxUtils  peut être utilisée avec le modificateur "--text"  qui apparaît lorsque vous utiliser le modificateur "--help". Sinon, la conversion des retours de chariot DOS vers la version UNIX ne peut se faire avec SED dans un environnement DOS.  Utiliser 'tr' au lieu.

	* UnxUtils sed v4.0.7 ou plus récent

			sed "s/\r//" infile >outfile

	* GNU tr version 1.22 ou plus récent

			tr -d \r <infile >outfile

* éliminer tout espace blanc (espaces, tabulations) à la gauche de chaque ligne, et appuyer le résultat à la marge gauche
	* voir note au sujet de '\t' à la fin de ce fichier

			sed 's/^[ \t]*//'

* éliminer tout espace blanc (espaces, tabulations) à la fin de chaque ligne
	* voir note au sujet de '\t' à la fin de ce fichier

			sed 's/[ \t]*$//'

* éliminer tout espace blanc des deux bouts de chaque ligne

		sed 's/^[ \t]*;s/[ \t]*$'

* insérer 5 espaces au début de chaque ligne (décalage de page vers la droite)

		sed 's/^/     /'

* aligner tout le texte à la droite sur la 79e colonne
	* mettre à 78 plus un espace

			sed -e :a -e 's/^.\{1,78\}$/ &/;ta'

* centrer tout le texte sur le centre de la 79e colonne.
	* Dans la première méthode, tout espace au début de la ligne est significatif, et des espaces sont ajoutés à la fin de la ligne.
	* Dans la deuxième méthode, les espaces précédant les lignes sont ignorés pendant le processus de centrage, et aucun espace n'est ajouté à la fin des lignes.
	* méthode 1

			sed  -e :a -e 's/^.\{1,77\}$/ & /;ta'

	* méthode 2

			sed  -e :a -e 's/^.\{1,77\}$/ &/;ta' -e 's/\( *\)\1/\1/'

# Conversion de texte et substitution (III)

* substituer (trouver et remplacer) "foo" avec "bar" sur chaque ligne
	* replacer seulement la première instance de la ligne

			sed 's/foo/bar/'

	* replacer seulement la quatrième instance de la ligne

			sed 's/foo/bar/4'

	* replacer toutes les instances de la ligne

			sed 's/foo/bar/g'

	* replacer l'avant-dernier cas 

			sed 's/\(.*\)foo\(.*foo\)/\1bar\2/'

	* replacer seulement le dernier cas

			sed 's/\(.*\)foo/\1bar/'

* substituer  "foo" par "bar" SEULEMENT pour les lignes contenant "baz"

		sed '/baz/s/foo/bar/g'

* substituer  "foo" par "bar" A L'EXCEPTION des lignes contenant "baz"

		sed '/baz/!s/foo/bar/g'

* substituer "scarlet" ou "ruby" ou "puce" par "red"
	* la plupart des seds

			sed 's/scarlet/red/g;s/ruby/red/g;s/puce/red/g'

	* GNU sed seulement

			gsed 's/scarlet\|ruby\|puce/red/g'

# Actions sur des lignes

* reverser l'ordre des lignes (émulation de "tac")
	* bug/boni dans HHsed v1.5 cause l'élimination des lignes vides

			sed '1!G;h;$!d'
			sed -n '1!G;h;$p'

* renverse l'ordre de chaque caractère sur une ligne (émulation de "rev")

		sed '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;D;s/.'

* joindre des paires de lignes ensemble côte-à-côte (émulation de "paste")

		sed '$!N;s/\n/ /'

* si une ligne se termine par une barre oblique inversée, joindre la ligne suivante à la présente

		sed -e :a -e '/\\$/N; s/\\\n//; ta'

* si une ligne débute par le symbole égalité, l'ajouter à la précédente et remplacer le symbole "=" par un espace simple

		sed -e :a -e '$!N;s/\n=/ /;ta' -e 'P;D'

* insérer des virgules aux chaînes numériques, changeant "1234567" en "1,234,567"
	* GNU sed

			gsed ':a;s/\B[0-9]\{3\}\>/,&/;ta'

	* autres seds

			sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'

* décimaux et signes négatifs (GNU sed)

		gsed -r ':a;s/(^|[^0-9.])([0-9]+)([0-9]{3})/\1\2,\3/g;ta'

* ajouter une ligne blanche à chaque cinq lignes (après lignes  5, 10, 15, 20, etc.)

		gsed '0~5G'
		sed 'n;n;n;n;G;'

# Imprimer d'une façon sélective certaines lignes (I)

* imprimer les dix premières lignes d'un fichier (émulation de "head")

		sed 10q

* imprimer la première ligne d'un fichier (émulation "head -1")

		sed q

* imprimer les dernières dix lignes d'un fichier (émulation "tail")

		sed -e :a -e '$q;N;11,$D;ba'

* imprimer les dernières deux lignes d'un fichier (émulation "tail -2")

		sed '$!N;$!D'

* imprimer la dernière ligne d'un fichier (émulation "tail -1")

		sed '$!d'
		sed -n '$p'

* imprimer l'avant-dernière ligne d'un fichier
	* pour fichiers d'une ligne , imprimer une ligne vide 

			sed -e '$!{h;d;}' -e x

	* pour fichiers d'une ligne , imprimer la ligne

			sed -e '1{$q;}' -e '$!{h;d;}' -e x

	* pour fichiers d'une ligne , ne rien imprimer

			sed -e '1{$d;}' -e '$!{h;d;}' -e x

* imprimer seulement les lignes coïncidant avec l'expression régulière regexp (émulation "grep")
	* méthode 1

			sed -n '/regexp/p'

	* méthode 2

			sed '/regexp/!d'

* imprimer seulement les lignes NE coïncidant PAS avec l'expression régulière regexp (émulation "grep -v")
	* méthode 1, corresponds avec méthode ci-haut

			sed -n '/regexp/!p'

	* méthode 2, syntaxe plus simple 

			sed '/regexp/d'
			
* imprimer la ligne précédant celle qui coïncide avec regexp, mais pas la ligne coïncidant avec regexp

		sed -n '/regexp/{g;1!p;};h'

* imprime la ligne suivant celle qui coïncide avec regexp, mais pas la ligne coïncidant avec regexp

		sed -n '/regexp/{n;p;}'

* imprime une ligne de contexte avant et après regexp, avec numérotation de lignes indiquant l'endroit de coïncidence avec regexp (similaire à "grep -A1 -B1")

		sed -n -e '/regexp/{=;x;1!p;g;$!N;p;D;}' -e h

# Grep-like

* grep pour AAA et BBB et CCC (peu importe l'ordre)

		sed '/AAA/!d; /BBB/!d; /CCC/!d'

* grep pour AAA et BBB et CCC (dans cet ordre)

		sed '/AAA.*BBB.*CCC/!d'

* grep pour AAA ou BBB ou CCC (émulation "egrep")
	* la plupart des seds

			sed -e '/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d
	
	* GNU sed seulement

			gsed '/AAA\|BBB\|CCC/!d'

# Imprimer d'une façon sélective certaines lignes (II)

* imprime paragraphe si il contient AAA (paragraphes séparés par des lignes vides) HHsed v1.5 veuillez insérer un  'G;' après 'x;' dans les trois commandes ci-bas

		sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;'

* imprime le paragraphe s'il contient AAA et BBB et CCC (peu importe l'ordre)

		sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;/BBB/!d;/CCC/!d'

* imprime le paragraphe s'il contient AAA ou BBB ou CCC

		sed -e '/./{H;$!d;}' -e 'x;/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d
		gsed '/./{H;$!d;};x;/AAA\|BBB\|CCC/b;d'

* imprime seulement les lignes longues de 65 caractères ou plus

		sed -n '/^.\{65\}/p'

* imprime seulement les lignes longues de moins de 65 caractères

		sed -n '/^.\{65\}/!p'
		sed '/^.\{65\}/d'

* imprime la partie du fichier depuis la coïncidence à l'expression régulière, jusqu'à la fin du fichier

		sed -n '/regexp/,$p'

* imprime la partie du fichier incluse par le numéros de ligne 8-12 inclusivement

		sed -n '8,12p'
		sed '8,12!d'

* imprime la ligne numéro 52

		sed -n '52p'
		sed '52!d'

	* méthode 3, très efficace sur de gros fichiers

			sed '52q;d'

* commençant avec la troisième ligne, imprimer chaque septième ligne

		gsed -n '3~7p'

		sed -n '3,${p;n;n;n;n;n;n;}'

* imprime la partie du fichier contenue entre deux expression régulières incluant celles contenant les expressions régulières
	* respecte les hauts de casse

			sed -n '/Iowa/,/Montana/p'

# Écrasement sélectif de certaines lignes

* imprime tout le fichier SAUF la section coïncidant avec deux expressions régulières

		sed '/Iowa/,/Montana/d'

* élimine les lignes consécutives identiques d'un fichier (émulation "uniq").
	* La première ligne d'un ensemble de lignes identiques consécutives est retenue, les autres éliminées

			sed '$!N; /^\(.*\)\n\1$/!P; D'

* élimine les lignes en duplicata, non-consécutives, d'un fichier.
	* Prenez garde de ne pas déborder les limites de la mémoire tampon sinon veuillez utiliser le GNU sed.

			sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P'

* éliminer toutes les linges sauf celles en duplicata (émulation "uniq -d").

		sed '$!N; s/^\(.*\)\n\1$/\1/; t; D'

* éliminer les dix première lignes d'un fichier

		sed '1,10d'

* écraser la dernière ligne d'un fichier

		sed '$d'

* écraser les deux dernières lignes d'un fichier

		sed 'N;$!P;$!D;$d'

* écraser les dix dernières lignes d'un fichier

		sed -e :a -e '$d;N;2,10ba' -e 'P;D'
		sed -n -e :a -e '1,10!{P;N;D;};N;ba'

* écraser chaque huitième ligne

		gsed '0~8d'
		sed 'n;n;n;n;n;n;n;d;'

* écraser les lignes coïncidant avec un patron

		sed '/patron/d'

* écraser TOUTES les lignes vides d'un fichier (émulation  "grep '.' ")

		sed '/^$/d'
		sed '/./!d'

* écraser toutes les lignes vides consécutives (sauf la première); aussi écrase toutes les lignes vides du début et de la fin d'un fichier (émulation "cat -s")

	* méthode 1, retient 0 ligne vide au début, 1 à la fin

			sed '/./,/^$/!d'

	* méthode 2, permet  1 ligne vide au début, 0  à la fin

			sed '/^$/N;/\n$/D'

* écraser toutes lignes vides CONSÉCUTIVES d'un fichier, sauf les deux premières:

		sed '/^$/N;/\n$/N;//D'

* écraser toutes les lignes vides au début d'un fichier

		sed '/./,$!d'

* écraser toutes les lignes vides de la fin d'un fichier

	* fonctionne sur tous les seds

			sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'

	* ibid, sauf  pour gsed 3.02.

			sed -e :a -e '/^\n*$/N;/\n$/ba'

* écrase la dernière ligne de chaque paragraphe

		sed -n '/^$/{p;h;};/./{x;/./p;}'

# Applications spéciales

* éliminer les sur-frappes nerf (char, retour) des pages man. La commande 'echo'  peut nécessiter le modificateur -e si vous utilisez Unix System V ou du shell bash.
	* double guillemets requis dans l'environnement Unix

			sed "s/.`echo \\\b`//g"

	* sous bash/tcsh, enfoncer Ctrl-V et ensuite Ctrl-H

			sed 's/.^H//g'

	* expression hexadécimale pour sed 1.5, GNU sed, ssed

			sed 's/.\x08//g'

* obtenir l'entête des messages Usenet/courriel
	* élimine tout ce qui suit la première ligne vide

			sed '/^$/q'

* obtenir le corps   des messages Usenet/courriel
	* élimine tout ce qui précède la première ligne vide

			sed '1,/^$/d'

* obtenir l'entête Sujet, mais élimine la portion initiale "Subject: "

		sed '/^Suject: */!d; s///;q'

* obtenir l'adresse de retour dans l'entête

		sed '/^Reply-To:/q; /^From:/h; /./d;g;q'

* parcourir et isoler l'adresse proprement dite. Extirpe l'adresse courriel par elle-même, du script précédent 

		sed 's/ *(.*); s/>.*; s/.*[:<] *//'

* ajouter un crochet et espace à chaque ligne (citer un message)

		sed 's/^/> /'

* écraser le crochet et espace précédant chaque ligne (enlever la citation du message)

		sed 's/^> //'

* écraser la plupart des étiquettes HTML (s'accommode des étiquettes multi-lignes)

		sed -e :a -e 's/<[^>]*>g;/</N;ba'

* extrait les parties uuencodées binaires, éliminant les entêtes superflues, de façon à garder seulement la partie uuencodée.
	* Les fichiers doivent être passé à sed dans le bon ordre.
	* La version 1 peut être passée depuis la ligne de commande; la version 2 peut faire partie d'un script de shell Unix. (Modifiée par un script originaire de Rahul Dhesi.)

	* vers. 1

			sed '/^end/,/^begin/d' file1 file2 ... fileX | uudecode

	* vers. 2

			sed '/^end/,/^begin/d' "$@" | uudecode

* triage des paragraphes d'un fichier par ordre alphabétique.
	* Les paragraphes sont séparés pour des lignes vides.  GNU sed utilise \v comme tabulation verticale, ou n'importe lequel caractère unique peut servir.

		sed '/./{H;d;};x;s/\n/={NL}=/g' file | sort | sed '1s/={NL}=//;s/={NL}=/\n/g'

		gsed '/./{H;d};x;y/\n/\v/' file | sort | sed '1s/\v//;y/\v/\n/'

* compresser en zip chaque fichier .TXT individuellement, écrasant le fichier source et assignant le nom du fichier compressé .ZIP au nom de base du fichier source .TXT (sous DOS: le modificateur "dir /b" retourne les noms de base des fichiers tout en majuscules)

		echo @echo off >zipup.bat

		dir /b *.txt | sed "s/^\(.*\)\.TXT/pkzip -mo \1 \1.TXT/" >>zipup.bat

* USAGE TYPIQUE:
~	Sed accepte une ou plusieurs commandes et les applique
	toutes, de façon séquentielle, à chacune des lignes d'entrée. Une fois
	que toutes les commandes furent exécutées à la première ligne d'entrée,
	cette ligne est envoyée vers la sortie, une deuxième ligne est lue
	comme nouvelle entrée, et le cycle se répète.  Les exemples précédents
	assument que l'entrée provient de l'entrée standard (ex. la console,
	normalement ce serait l'entrée dans un pipeline). Un ou plusieurs
	noms de fichiers peuvent être ajoutés à la ligne de commande si l'entrée
	ne provient pas de l'entrée standard. La sortie est passée à la
	sortie standard (stdout ou l'écran-témoin).
~	Donc:

	**cat nomdefichier | sed '10q'				**# utilise entrée pipeline
	* sed '10q' nomdefichier					**# même chose, en moins du cat inutile
	* sed '10q' nomdefichier > nouveaufichier	**# re dirige la sortie vers le disque


Pour des renseignements additionnels sur la syntaxe, incluant 
comment fournir les instructions sed à partir d'un fichier au lieu
de la ligne de commande, veuillez consulter le livre "SED &
AWK, 2nd Edition," par Dale Dougherty et Arnold Robbins (O'Reilly,
1997; http://www.ora.com), "UNIX Text Processing," par Dale Dougherty
and Tim O'Reilly (Hayden Books, 1987) ou les tutoriels par Mike Arst
distribués dans U-SEDIT2.ZIP (plusieurs sites). Afin d'exploiter la
pleine puissance de sed, l'usager doit comprendre les 'expressions
régulières'. A cette fin, consultez "Mastering Regular Expressions" 
par Jeffrey Friedl (O'Reilly, 1997). Le manuel UNIX ("man") contient 
des pages qui pourraient être utiles ("man sed", "man regexp", ou la
sous-section sur les expressions régulières ("man ed"), quoique les 
pages man sont notoires pour leur difficultés. Elles ne furent pas
rédigées pour enseigner l'usage de sed ou des expressions régulières,
mais comme texte de référence pour ceux qui connaissent déjà 
ces outils.

SYNTAXE DE CITATION:
~	Les exemples précédents utilisent les
	guillemets simples ('...') au lieu des guillemets doubles ("...")
	pour encadrer ou citer les commandes d'édition, puisque sed est 
	typiquement utilisé sur les systèmes d'exploitation UNIX.  Les guillemets
	simples préviennent le shell UNIX d'interpréter les symbole dollar ($) 
	ainsi que les guillemets renversés (`...`) qui seraient interprétés
	par le shell s'ils seraient encadrés ou cités par les guillemets doubles.
	Les usagers du shell "csh" et dérivés doivent aussi citer le 
	point d'exclamation avec l'oblique arrière (\!) si l'on veut que
	les exemples ci-haut fonctionnent, même à l'intérieur de
	guillemets simples.  Les versions de sed écrites pour DOS
	invariablement requièrent des guillemets doubles ("...") au
	lieu  des guillemets simples utilisés pour citer les commandes
	d'édition sed.

L'USAGE DE '\t' DANS LES SCRIPTS SED:
~	Afin de clarifier la documentation, nous avons utilisé l'expression
	'\t' pour indiquer le caractère de tabulation (0x09) dans les scripts.
	Cependant, la plupart des versions de sed ne reconnaissent pas
	l'abréviation '\t', donc, lorsque vous écrirez ces directives
	à l'invite de commande, vous devrez enfoncer la clef TAB au lieu de
	l'abréviation.  '\t' est supporté comme métacharactère d'expression 
	régulière dans awk, perl, et HHsed, sedmod, et GNU sed v3.02.80.

VERSIONS DE SED:
~	Les version de sed diffèrent entre elles, et de
	légers écarts de syntaxe se présentent.  En particulier, la plupart
	ne reconnaissent pas l'usage d'étiquettes (:nom) ou ne permettent
	pas les instructions de branchement (b,t) à l'intérieur des commandes
	d'édition, sauf à la fin de ces commandes.  Nous avons donc utilisé
	une syntaxe qui serait portable à la majorité des usagers de divers
	sed, bien que les versions les plus populaires du GNU sed permettent
	une syntaxe plus élaborée.  Lorsque les lecteurs verront une longue
	chaîne de commande telle celle-ci:

		sed -e '/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d

ils seront réjouis de savoir que GNU sed leur permettra de réduire
le tout en ceci:

		sed '/AAA/b;/BBB/b;/CCC/b;d'	**# ou bien encore en ceci:
		sed '/AAA\|BBB\|CCC/b;d'

En plus, se rappeler que bien que certaines versions de sed acceptent
une commande telle "/one/ s/RE1/RE2/",  d'autres ne permettent pas ceci:
"/one/! s/RE1/RE2/", qui contient un espace avant le 's'. Éviter d'enter
l'espace lorsque vous entrez la commande.

OPTIMISATION POUR VITESSE D'EXÉCUTION:
Lorsque vous avez besoin de vitesse pour l'exécution de vos scripts
(si vos fichiers d'entrée sont volumineux, ou un processeur lent
ou un disque dur lent) la substitution sera plus rapide si vous
faites un recherche pour la chaîne à être changée avant de faire
la substitution "s/.../.../".  Voir:

		sed 's/foo/bar/g' nomdefichier          # commande normale de substitution
		sed '/foo/ s/foo/bar/g' nomdefichier    # exécution plus rapide
		sed '/foo/ s//bar/g' nomdefichier       # raccourci de syntaxe

Si vous devez altérer ou écraser seulement une section d'un fichier
et que vous voulez seulement une sortie pour une première partie
d'un fichier quelconque, la commande "quit" (q) dans le script
réduira considérablement le temps d'exécution pour de gros fichiers.
Donc:

		sed -n '45,50p' nomdefichier            # imprimez les lignes nos. 45-50 d'un fichier
		sed -n '51q;45,50p' nomdefichier        # ibid, mais bien plus vite
	
Si vous avez des scripts additionnels à contribuer, ou si vous trouvez
des erreurs dans ce document, S.V.P. envoyer un courriel au compilateur
du document. Indiquez quelle version de sed vous utilisez, le système
d'exploitation en usage et pour laquelle votre sed fut compilé, ainsi
que la nature de votre problème.  Afin de se qualifier comme un script
d'une ligne, la commande doit avoir moins de 65 caractères.  Divers 
scripts dans ce fichiers furent rédigés ou contribués par les bonnes
gens suivants:

* Al Aab				# fondateur de la liste "seders" 
* Edgar Allen				# divers
* Yiorgos Adamopoulos			# divers
* Dale Dougherty			# auteur de "sed & awk"
* Carlos Duarte				# auteur de "do it with sed"
* Eric Pement				# auteur de ce document
* Ken Pizzini				# auteur de GNU sed v3.02
* S.G. Ravenhall			# superbe script de-html 
* Greg Ubben				# beaucoup de contributions & d'aide

