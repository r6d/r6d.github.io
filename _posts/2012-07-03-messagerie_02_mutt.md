---
layout: post
title: "Messagerie - Mutt"
date: 2012-07-03 12:56:32 +0200
comments: false
tags: [mail, mutt]
---

# Messagerie - client email Mutt

## Accès à une boîte en IMAP

* Relever des mails directement en imap
* user / password

	```bash
	$ mutt -f imaps://<user>@<server>
	```

* user complexe (adresse mail)

	```bash
	$ mutt -f imaps://'<doe@example.com>'@imap.example.com
	```

## Supprimer des doublons (par id de message)

*  [Article original](http://promberger.info/linux/2008/03/31/mutt-delete-duplicate-e-mail-messages/)]

	[...]. En réalité, c'est très simple, vous pouvez ignorer l'étape de marquage et simplement taper `D` (pour _delete matching pattern_, soit _suppression par reconnaissance de motif_) suivi de `~=`.

	Pour ce faire (commande à taper dans mutt)

	```text
	D ~=
	```


## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
