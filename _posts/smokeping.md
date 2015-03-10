
# Smokeping et Docker

[le container dperson/smokeping](https://registry.hub.docker.com/u/dperson/smokeping/)

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
