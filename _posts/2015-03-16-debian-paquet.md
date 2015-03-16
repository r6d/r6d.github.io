---
layout: post
title: "Comment installer un paquet récalcitrant sous Ubuntu / Debian-like ?"
date: 2015-03-16 13:43:000 +0100
comments: false
tags: [adminsys]
---

# Comment installer un paquet récalcitrant sous Ubuntu / Debian-like ?

Un des problèmes courants lors d'une grosse mise à jour système directement en changeant les fichiers `sources.list` est la présence de deux paquets dans deux versions différentes mais avec deux identifiants de version différents.

Dans un tel cas, le gestionnaire de paquet propose une mise à jour qui échoue du fait de la présence de certains fichiers.

Lorsque le paquet en question est le kernel, vous êtes mal ...

Les sympômes sont indiqués [ici](https://www.debian-fr.org/probleme-de-fichier-remplaces-lors-de-mises-a-jour-t13818.html).

```
dpkg : erreur de traitement de /var/cache/apt/archives/cupsys_1.3.7-4_amd64.deb (--unpack) :
 tentative de remplacement de « /usr/lib/cups/daemon/cups-lpd », qui appartient aussi au paquet cupsys-bsd
dpkg-deb: sous-processus paste tué par le signal (Relais brisé (pipe))
```

## Pour les utilisateurs de `dpkg`

Une solution est indiqué dans le même thread.

```bash
$ dpkg -i --force-overwrite cupsys_1.3.7-4_amd64.deb
```

## Pour les utilisateur d'aptitude

```bash
$  apt-get -o Dpkg::Options::="--force-overwrite" <nom du paquet>
```

### dans mon cas

Commande :

```bash
$  apt-get -o Dpkg::Options::="--force-overwrite" install linux-image-extra-3.13.0-46-generic
```

Résultat :

```
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-wm8350.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-palmas.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-ds1286.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-s5m.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-ds3232.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-ds1553.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-max8907.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-bq32k.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-ds1672.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-max6900.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-rv3029c2.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-ds1390.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-ds1374.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-ds1742.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-r9701.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-pcf2123.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-ds1305.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-ds2404.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1
dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/drivers/rtc/rtc-m48t86.ko », qui appartient aussi au paquet linux-image-3.13.0-46-generic 3.13.0-46.79~precise1

[...]

dpkg : avertissement : problème contourné par utilisation de --force :
dpkg : avertissement : tentative de remplacement de « /lib/modules/3.13.0-46-generic/kernel/net/sunrpc/xprtrdma/xprtrdma.ko », qui appartient aussi au paquet linux-image-3.13.0-46-g
eneric 3.13.0-46.79~precise1
Paramétrage de linux-image-extra-3.13.0-46-generic (3.13.0-46.79) ...
run-parts: executing /etc/kernel/postinst.d/apt-auto-removal 3.13.0-46-generic /boot/vmlinuz-3.13.0-46-generic
run-parts: executing /etc/kernel/postinst.d/initramfs-tools 3.13.0-46-generic /boot/vmlinuz-3.13.0-46-generic
update-initramfs: Generating /boot/initrd.img-3.13.0-46-generic
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8168g-3.fw for module r8169
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8168g-2.fw for module r8169
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8106e-2.fw for module r8169
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8106e-1.fw for module r8169
W: Possible missing firmware /lib/firmware/rtl_nic/rtl8411-2.fw for module r8169
run-parts: executing /etc/kernel/postinst.d/zz-update-grub 3.13.0-46-generic /boot/vmlinuz-3.13.0-46-generic
Generating grub.cfg ...
Found linux image: /boot/vmlinuz-3.13.0-46-generic
Found initrd image: /boot/initrd.img-3.13.0-46-generic
Found linux image: /boot/vmlinuz-3.13.0-24-generic
Found initrd image: /boot/initrd.img-3.13.0-24-generic
Found memtest86+ image: /boot/memtest86+.bin
done
Paramétrage de linux-image-generic (3.13.0.46.53) ...
Paramétrage de linux-generic (3.13.0.46.53) ...
```

SUCCESS.
