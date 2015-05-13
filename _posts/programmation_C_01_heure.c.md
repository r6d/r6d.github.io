# heure.c

* code

~~~~ {.c}
#include <stdio.h>

int main(void) {
	//  1 unité -> 60 secondes = 1 minute
	long echelle = 60;
	long s = 28000*echelle;

	int annee   = s / 60 / 60 / 24 / 365;
	int jour    = s / 60 / 60 / 24 % 365;
	int heure   = s / 60 / 60 % 24;
	int minute  = s / 60 % 60;
	int seconde = s % 60;

	printf("\n%d an(s), %d jour(s), %d heure(s), %d minute(s), %d seconde(s)\n\n",
		 annee,		jour,	heure,		minute,		seconde);
	return 0;
}
~~~~

## Licence

![logo creative common by-sa 3.0](http://i.creativecommons.org/l/by-sa/3.0/88x31.png)
[Creative Commons Paternité – Partage à l’Identique 3.0 non transcrit](http://creativecommons.org/licenses/by-sa/3.0/)
