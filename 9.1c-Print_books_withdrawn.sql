SELECT homebranch, COUNT(*)
FROM deleteditems
WHERE YEAR(timestamp)= <<Year (YYYY)>>
    AND (ccode = 'AB' OR ccode = 'JB')
    AND homebranch <> 'ROTATION'
GROUP BY homebranch
ORDER BY homebranch
LIMIT 50
