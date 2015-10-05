
Suppression massive de fichiers, 25 processus en simultané

find . -type f -print0 | xargs -0 -P25 rm -v
