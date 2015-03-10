
# Smokeping et Docker

## 

[le container dperson/smokeping](https://registry.hub.docker.com/u/dperson/smokeping/)

## Commande pour ajouter en masse des cibles à suveiller

Plage d'adresse : 192.168.21.0/24

```bash
for i in `seq 1 254`; do docker exec smoke_jpp smokeping.sh -t "All;host_${i};192.168.21.${i}"; done
```

## Commande pour actualiser les données depuis le sysème hôte

```bash
while true; do docker exec smoke_jpp smokeping --debug; sleep 300; done
```
