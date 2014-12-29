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
