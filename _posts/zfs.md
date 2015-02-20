```bash
zfs set snapdir=visible my/btsync/rd
```
```bash
zfs set snapdir=hidden my/btsync/rd
```

```
all: 
	date

zfs-show:
	zfs set snapdir=visible my/btsync/rd

zfs-hide:
	zfs set snapdir=hidden my/btsync/rd
```
