---
layout: post
title: "IPv6 et Docker, Ubuntu 12 LTS"
date: 2015-02-23 20:20:000 +0100
comments: false
tags: [reseau, docker]
---

# IPv6 et docker, machine avec Ubuntu 12.04.5 LTS

* [documentation officielle](https://docs.docker.com/articles/networking/#ipv6-with-docker)

## Objectif

Il s'agit de pouvoir affecter des adresses IPv6 aux containers hébergés sur une machine dotée d'un bloc d'addresses IPv6 publiques.

## Solution utilisée

ip -6 addr add 2001:41d0:8:9875:40::1/80 dev docker0
ip -6 route add 2001:41d0:8:9875:40::1/80 dev docker0

* [bug indiquant la solution utilisée ici](https://github.com/docker/docker/issues/10045)

>
> Docker checks if the IPv6 address of docker0 is fe80::1/64. If not it fails.
> You have two options:
>
> 1. Remove the bridge and let Docker create a new one
>
> > ifconfig docker0 down
> > brctl delbr docker0
>
> 2. Just set the IPv6 address manually
>
> > ifconfig docker0 inet6 add fe80::1/64
>
> I'd recommend 2.
>

## Affichage de la configuration réseau

```bash
ip -6 addr show docker0
ip link show
```

## Lancement du daemon docker

```bash
$ docker -d --ipv6 --fixed-cidr-v6="2001:41d0:8:9875:40::1/80" --ip-forward=true
```

## Affichage de la configuration réseau vu de l'intérieur d'un container

```bash
$ docker run --rm -it ubuntu bash -c "ip -6 addr show dev eth0; ip -6 route show" --ipv6
```
