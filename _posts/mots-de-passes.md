
## Liste de sites

dropbox
bank
clé ssh
mot de passes enregistrés
accès sur des serveurs
facebook
twitter
LinkedIn
comptes mail hotmail, yahoo, gmail, skype
htaccess
impots
code de porte
code wifi
code adsl free, orange, etc.
sites d'achat en ligne
apple store
accès ftp sur d'autre sites etc.

--

http://superlogout.com/

--

Le souci du chiffrement natif des OS Win et Mac c'est qu'on sait qu'ils sont permissifs au travers d'application de forensic.
Pas trop le temps de vous retrouver les liens qui en parlent mais ça doit pas être compliqué à trouver puis bon c'est pas comme si une loi imposait à un éditeur ou fabricant de matos de donner un moyen d'accès (master key) au gouvernement US quand ils veulent vendre sur le territoire.
Bref il reste le chiffrement luks sous Linux où il ne me semble pas avoir vu passer de news là dessus mais ça doit propablement exister.

Pour ma part je procède ainsi pour les portables :

* chiffrement des partitions par l'OS, ça bloque les voleurs de portables c'est toujours ça.
* mot de passe session pour verrouiller rapidement c'est quand même pratique.
  J'avais tenté de chiffrer mon home sous Linux en plus de l'os mais même sur un ssd ça commençait à ramer
* une fois logué, faut que je monte un conteneur Trucrypt pour accéder à mes documents, clef ssh, certificats et fichiers Keepassx
* Firefox n'a pas le droit d'enregistrer de mot de passe, pour l'authentification on utilise des certificats ssl dans le navigateur.
  Je bloque tous les cookies tiers en dehors du domaine que je visite et les cookies et sessions du site sont purgés dès que je ferme l'onglet.

Avec cela je dors un peu plus tranquille même si y a forcément toujours moyen de pénétrer au travers de ces défenses.

