-- Remove logs for all buffer for networl 3

DELETE FROM backlog WHERE bufferid IN (SELECT bufferid FROM buffer WHERE networkid IN (3));

