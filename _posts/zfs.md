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

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
