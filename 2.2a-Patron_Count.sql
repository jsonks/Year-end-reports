SELECT branchcode,
CONCAT('<a target="_blank" href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=1944&phase=Run+this+report&param_name=Choose+Library%7CSLIBS&sql_params=',branchcode,'\">',COUNT(borrowernumber),'</a>') AS count
FROM borrowers
WHERE categorycode <> 'ILL'
    AND branchcode <> 'DOWNLOAD'
    AND branchcode <> 'NEOSHOCC'
GROUP BY branchcode
UNION ALL
SELECT 'TOTAL', count(borrowernumber) AS count
FROM borrowers
WHERE categorycode <> 'ILL'
    AND branchcode <> 'DOWNLOAD'
    AND branchcode <> 'NEOSHOCC'
LIMIT 100
