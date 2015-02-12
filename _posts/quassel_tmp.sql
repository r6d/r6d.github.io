SELECT count(*) as count______________, buf.buffername, n.networkname, n.networkid
FROM backlog log
NATURAL JOIN buffer buf
NATURAL JOIN network n

WHERE n.networkid=37

GROUP BY buf.buffername, n.networkname, n.networkid
ORDER BY count(*) DESC
LIMIT 100