---
layout: post
title: "RabbitMQ et la répartition de tâche facile"
date: 2015-12-19 17:00:000 +0100
comments: false
tags: [amqp, rabbitmq]
---

# Note sur l'équilibrage de charge de calcul sur plusieurs machines

## Préparation du broker

Les commandes fournie par la suite `amqp-tool` sont utiles mais la version packagée dans homebrew (gestionnaire de paquet pour Mac OS X) n'ont pas la capacité de déclarer la configuration du serveur.
Il faut donc réaliser la configuration sur le serveur *avant* de continuer.

Il faut pour cela déclarer un point d'échange.
Dans le cas d'exemple, ce sera `dns_ex`.

![](/assets/files/2015/12/dns_ex.png)

Afin de pouvoir conserver les tâches même si aucun exécuteur n'est lancé nous ajoutons manuellement une file de message.
Ajoutons la queue `q_dns_ttl` avec une expiration automatique des messages à 1 jour (= 24 * 60 * 60 * 1000 = 86400000 ms).

![](/assets/files/2015/12/q_dns_ttl.png)

Afin de recevoir des tâches dans la file d'attente, il faut associer la file avec le point d'échange.

On accepte tous les messages entrant dans le point d'échange (routing key = "#").

![](/assets/files/2015/12/q_dns_ttl-binding.png)
 

## Publication des tâches

### Préparation des données à fournir à notre tâche

Pour l'exemple, utilisons la liste des sites les plus populaires fournie par Alexa.

script issu de [gist.github.com](https://gist.github.com/evilpacket/3628941)

```bash
wget -q http://s3.amazonaws.com/alexa-static/top-1m.csv.zip
unzip top-1m.csv.zip
awk -F ',' '{print $2}' top-1m.csv|head -1000 > top-1000.txt
rm top-1m.csv*
```

### Le script `bash` qui constitue la tâche

Contenu du fichier `dig.sh` :

```bash
read line
echo "Message: $line"
dig $line
```

On le rend exécutable :

```bash
chmod +x dig.sh
```

## Exécution des tâches

### Envois des tâches

Explication rapide des options :

* "-e" : exchange name : le nom du point d'échange
* "--url" : l'URL de connexion au serveur.
* "-l" : pour prendre chaque line en entrée comme un message séparé

```bash
cat top-1000.txt  | amqp-publish -e "dns_ex" --url=amqp://guest:guest@localhost:5672 -l
```

![](/assets/files/2015/12/envois.png)

### Réception et exécution

Explication rapide des options :

* "-q" : queue name : le nom de la file d'attente
* "-p" : prefech : le nombre de message à prendre dans la file. Permet d'aumenter les performances si la tâche est rapide par rapport au temps de transfert du message.

```bash
amqp-consume -q "q_dns_ttl" --url=amqp://guest:guest@localhost:5672 -p 1 ~/dig.sh
```

## Liens

* [RabbitMQ et Bash, wlanboy.com](http://www.wlanboy.com/tutorial/rabbitmq-bash)
* [amqp-tool, npmjs.com](https://www.npmjs.com/package/amqp-tool)

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
