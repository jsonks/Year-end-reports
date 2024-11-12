SELECT i.homebranch, COUNT(*)
FROM items i
WHERE YEAR(i.dateaccessioned) = <<Year>>
     AND (i.ccode = 'AB' OR i.ccode = 'JB')
     AND homebranch <> 'ROTATION'
GROUP BY i.homebranch
ORDER BY i.homebranch
LIMIT 50
