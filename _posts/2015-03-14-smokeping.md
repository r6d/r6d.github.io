---
layout: post
title: "Smokeping et Docker"
date: 2015-03-10 14:11:000 +0100
comments: false
tags: [reseau, docker]
---

# Smokeping et Docker

* [le container dperson/smokeping](https://registry.hub.docker.com/u/dperson/smokeping/)
* [le dépot github](https://github.com/dperson/smokeping)

## Création du container 

```bash
docker run --name smoke_r6d -p 8000:80 -d dperson/smokeping
```

## Ajout en masse des cibles à suveiller

Plage d'adresse : 192.168.21.0/24

```bash
for i in `seq 1 254`; do docker exec smoke_r6d smokeping.sh -t "All;host_${i};192.168.21.${i}"; done
```

## Actualiser les données depuis le sysème hôte (débug)

```bash
while true; do docker exec smoke_r6d smokeping --debug; sleep 300; done
```

## Ajout en masse de cibles de suivi par le DNS

``` bash
for h in `dig +short NS com.`; do docker exec smoke_r6d smokeping.sh -t "DNS_com;$h;$h"; done
for h in `dig +short NS fr.`; do docker exec smoke_r6d smokeping.sh -t "DNS_fr;$h;$h"; done
```

Pour corriger le nom de la reference smokeping (ne doit pas contenir de .)

```bash
docker exec smoke_r6d sed -i '/++/s/\./_/g' /etc/smokeping/config.d/Targets
```

## Ajout en masse de supervision des TLD

```bash
#!/bin/sh

TLDS=`curl https://data.iana.org/TLD/tlds-alpha-by-domain.txt|grep -v ^#`

for tld in ${TLDS};
do
        for h in `dig +short NS ${tld}.`;
        do
                name=$( echo $h | sed 's/\./_/g' )
                config="DNS_${tld};${name};${h}"
                #docker exec smoke_r6d smokeping.sh -t "${config}";
                echo $config
        done
done
```
