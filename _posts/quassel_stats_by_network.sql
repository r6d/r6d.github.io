SELECT count(*) as count__________, n.networkname, n.networkid
FROM backlog
NATURAL JOIN buffer buf
NATURAL JOIN network n

GROUP BY n.networkname, n.networkid
ORDER BY count(*) DESC
LIMIT 100;