# Welcome to the libs wiki! -  Notes, outils, liens & méthodes

## Linux

* Informations sur un utilisateur système

	```bash
	$ finger username
	```~

* Réinitialiser le compteur des interfaces réseaux

	```bash
	$ cat /etc/udev/rules.d/70-persistent-net.rules
	```

* show all listening TCP/UDP ports

	```bash
	$ lsof -Pan -i tcp -i udp
	```

* label disk — mount point

	```bash
	$ df -T | awk '{print $1,$2,$NF}' | grep "^/dev"
	```

## Traitement du signal

* automatique
	Équation classique de traitement de signal (système bouclé)

	1. $y(h) = \dfrac{b_1 q^{-1}} {1+a_1 q^{-1}} u(h)$

	1. $(1+a_1 q^{-1}) y(h) = (b_1 q^{-1}) u(h)$

	1. $y(h) + a_1 y(h-1) = b_1 u(h-1)$

	1. $y(h) = b_1 u(h-1) - a_1 y(h-1)$

## Debian

* aptitude

	```bash
	$ aptitude purge `aptitude search [a-z]|grep ^c|awk '{print $2, " "}'| tr -d "\n"`
	```

## Linux

* ouverture en masse dans un explorateur de fichiers

	```bash
	$ find `pwd` -type d -exec bash -c 'i="{}" && echo $i && pcmanfm "$i" && sleep 2' \;
	$ find `pwd` -type d -print0 | xargs -0 pcmanfm
	```

* inversion de chaine de caractère

	```bash
	$ echo 'g p j . h s a l c / s e g a m i / g r o . c i g a m i l c . w w w / / : p t t h' | tr -d ' ' | rev
	```

* create an empty file of 4 GByte / Go)

	```bash
	$ dd if=/dev/zero of=blue-verbatim.img bs=1000 count=0 seek=$[1000*1000*4]
	```

## IRC

* envoyer une chaine de caractères dans un canal irc par la console

```bash
#!/bin/bash
## connect
# ii -s irc.<serveur>.fr -n iibot
## join
echo "/PRIVMSG #chan :$@" > ~/irc/irc.<server>.fr/#chan/in
```

## GPG (non testé)

```bash
#!/bin/sh

gpg --list-sigs | sed -rn '/User ID not found/s/^sig.+([a-FA-F0-9]{8}).*/\1/p' | xargs -i_ gpg --keyserver-options no-auto-key-retrieve --recv-keys _
```

## Liens

* Bogons [[www.team-cymru.org](http://www.team-cymru.org/Services/Bogons/bgp.html)] et [[www.team-cymru.org > BGP example](http://www.team-cymru.org/Services/Bogons/bgp-examples.html#quagga-full)]

* iptables [[linux-attitude.fr](http://linux-attitude.fr/post/firewall-en-2-temps-3-mouvements)]

* matrix (parodie) [[www.youtube.com](http://www.youtube.com/watch?v=yX8yrOAjfKM&NR=1&feature=fvwp)]

* [[badBios](http://www.developpez.com/actu/63658/badBIOS-le-rootkit-qui-infecte-les-BIOS-et-communique-par-les-airs-Windows-OS-X-Linux-et-BSD-sont-tous-vulnerables/)]

* http://trac.evolix.net/infogerance/wiki/HowtoRIPE

## Notes en vrac

* Message Sequence Chart -- Msc (mscgen)
* [librairie rfid liblogicalaccess](http://www.liblogicalaccess.islog.com)
* zcat /var/log/?.gz

## Linux

BUSIER -> REISUB, Alt+SysRq

## Picviz - pcv

* monothread
* $400k$ lignes : $\approx 2 min 20$ pour $4$ axes.

```bash
$ pcv -Tpngcairo -Rheatline -Avirus -r...ra log.pcv
	`show plop >10% on axis 1 and plot <20% on axis 2`
	> img.png
```
