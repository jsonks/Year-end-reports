SELECT s.branch,
SUM(CASE WHEN(COALESCE(i.permanent_location, di.permanent_location) LIKE ("%0AD%") OR COALESCE(i.permanent_location, di.permanent_location) LIKE ("%0LP%") OR COALESCE(i.permanent_location, di.permanent_location) LIKE ("%0NEW%")) THEN 1 ELSE 0 END) AS ADULTcount_111,
SUM(CASE WHEN(COALESCE(i.permanent_location, di.permanent_location) LIKE ("%YA%") OR COALESCE(i.permanent_location, di.permanent_location) LIKE ("%JUV%")) THEN 1 ELSE 0 END) AS JUVcount_112,
SUM(CASE WHEN(COALESCE(i.permanent_location, di.permanent_location) NOT LIKE ("%0AD%") AND COALESCE(i.permanent_location, di.permanent_location) NOT LIKE ("%0LP%") AND COALESCE(i.permanent_location, di.permanent_location) NOT LIKE ("%0NEW%") AND COALESCE(i.permanent_location, di.permanent_location) NOT LIKE ("%JUV%") AND COALESCE(i.permanent_location, di.permanent_location) NOT LIKE ("%YA%") AND COALESCE(i.permanent_location, di.permanent_location) NOT LIKE ("%0ILL%")) THEN 1 ELSE 0 END) AS OTHcount_114,
SUM(CASE WHEN(COALESCE(i.permanent_location, di.permanent_location) LIKE ("%0ILL%")) THEN 1 ELSE 0 END) AS ILL,
SUM(CASE WHEN(COALESCE(i.permanent_location, di.permanent_location) IS NULL) THEN 1 ELSE 0 END) AS NULLisland,
COUNT(*) AS total
FROM statistics s
LEFT JOIN items i ON s.itemnumber=i.itemnumber
LEFT JOIN deleteditems di ON s.itemnumber=di.itemnumber
LEFT JOIN borrowers b ON s.borrowernumber=b.borrowernumber
WHERE YEAR(s.datetime)  = <<Year(YYYY)>>
    AND s.type IN ('issue', 'renew', 'localuse')
    AND b.categorycode <> 'ILL'
GROUP BY s.branch    
LIMIT 200
