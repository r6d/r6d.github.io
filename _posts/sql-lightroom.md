# Extraction de données depuis un catalogue Lightroom

TODO


## Ressources

* [John07/lightroom-exporting.sql](https://gist.github.com/John07/119fc5d1ea1d84677763)

(Requêtes non testées)

```sql
sqlite3 backup-catalog.lrcat
.output export.txt

-- get all keywords with their id
SELECT id_local, name FROM AgLibraryKeyword;

-- get list of all files with keyword id 88890
SELECT stackParent_fileName, stackParent____colorLabels, rating
FROM Adobe_images AS a
JOIN AgLibraryKeywordImage AS b
WHERE b.tag=88890 AND a.id_local=b.image;

-- get list of all files for keyword Bob
SELECT stackParent_fileName, stackParent____colorLabels, rating
FROM Adobe_images AS a
JOIN AgLibraryKeywordImage AS b
JOIN AgLibraryKeyword AS c
WHERE c.name="Bob" AND b.tag=c.id_local AND a.id_local=b.image;

-- get list of all files with color label Green
SELECT stackParent_fileName, stackParent____colorLabels, rating
FROM Adobe_images
WHERE stackParent____colorLabels is "Green";

-- get list of all files with a 4 star rating in a folder named Holiday
SELECT stackParent_fileName, foldername.name, rating
FROM Adobe_images AS info
JOIN AgLibraryRootFolder AS foldername
JOIN AgLibraryFolder AS folderid
JOIN AgLibraryFile AS filetofolder
where foldername.name="Holiday" AND foldername.id_local=folderid.rootFolder AND folderid.id_local=filetofolder.folder AND filetofolder.id_local=info.rootFile AND rating=4.0;

-- get list of all files with pick=0 and color label Green in a folder named Holiday
SELECT stackParent_fileName, foldername.name, rating, colorLabels
FROM Adobe_images AS info
JOIN AgLibraryRootFolder AS foldername
JOIN AgLibraryFolder AS folderid
JOIN AgLibraryFile AS filetofolder
where foldername.name="Holiday" AND foldername.id_local=folderid.rootFolder AND folderid.id_local=filetofolder.folder AND filetofolder.id_local=info.rootFile AND info.pick=0.0 AND info.colorLabels="Green";

-- get list of all files with their associated keywords (but only files with a keyword)
SELECT stackParent_fileName, foldername.name, keywordstofiles.name, rating, colorLabels
FROM Adobe_images AS info
JOIN AgLibraryRootFolder AS foldername
JOIN AgLibraryFolder AS folderid
JOIN AgLibraryFile AS filetofolder
JOIN AgLibraryKeywordImage AS keyworddirectory
JOIN AgLibraryKeyword AS keywordstofiles
WHERE keyworddirectory.tag is not null AND keyworddirectory.tag=keywordstofiles.id_local AND info.id_local=keyworddirectory.image AND foldername.id_local=folderid.rootFolder AND folderid.id_local=filetofolder.folder AND filetofolder.id_local=info.rootFile;

-- get list of all files with their rating (but only files with a rating)
SELECT stackParent_fileName, foldername.name, rating, colorLabels
FROM Adobe_images AS info
JOIN AgLibraryRootFolder AS foldername
JOIN AgLibraryFolder AS folderid
JOIN AgLibraryFile AS filetofolder
WHERE info.rating is not null AND foldername.id_local=folderid.rootFolder AND folderid.id_local=filetofolder.folder AND filetofolder.id_local=info.rootFile;

-- export collections: http://blog.codekills.net/2010/09/12/lightroom--export-a-list-of-pictures-in-a-catalog/
```
