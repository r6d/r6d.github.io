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
	mutt -f imaps://<user>@<server>
	```

* user complexe (adresse mail)

	```bash
	mutt -f imaps://'<doe@example.com>'@imap.example.com
	```

## Supprimer des doublons (par id de message)

* Remove duplicates email messages [[http://promberger.info/linux/2008/03/31/mutt-delete-duplicate-e-mail-messages/](http://promberger.info/linux/2008/03/31/mutt-delete-duplicate-e-mail-messages/)]

	Actually, it’s much easier, you can skip the tagging step and just do *D* (for “delete matching pattern” followed by *~=*.

	Pour ce faire (commande à taper dans mutt)

	```text
	D ~=
	```
