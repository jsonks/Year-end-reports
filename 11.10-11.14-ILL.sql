SELECT b.branchcode, bi.count AS IntBorrows, bo.count AS ExtBorrows, CONCAT('<strong>', (bi.count + bo.count), '</strong>') AS TotBorrows, l.count AS IntLoans, lo.count AS ExtLoans, CONCAT('<strong>', (l.count + lo.count), '</strong>') AS TotLoans
FROM branches b
LEFT JOIN (
  SELECT branchtransfers.tobranch AS branch, COUNT(*) AS count
  FROM branchtransfers 
  LEFT JOIN items ON (branchtransfers.itemnumber=items.itemnumber) 
  WHERE (branchtransfers.tobranch != items.homebranch) 
  AND (items.homebranch != 'ROTATION')
  AND (branchtransfers.tobranch != branchtransfers.frombranch)
  AND YEAR(datesent) = <<YEAR>>
  GROUP BY tobranch) bi ON (bi.branch=b.branchcode)
LEFT JOIN (
  SELECT s.branch, SUM(CASE WHEN (s.itemtype LIKE 'ILL%') THEN 1 ELSE 0 END) as count
  FROM statistics s
  WHERE s.type IN ('issue','renew') 
    AND YEAR(s.datetime) = <<YEAR>>
  GROUP BY s.branch) bo ON (bo.branch=b.branchcode)
LEFT JOIN (
  SELECT branch, SUM(CASE WHEN(b.categorycode = "ILL") THEN 1 ELSE 0 END) AS count
  FROM statistics s
  JOIN borrowers b USING (borrowernumber) 
  WHERE s.type IN ("issue", "renew")
     AND YEAR(s.datetime) = <<YEAR>>
  GROUP BY branch ) lo ON (lo.branch=b.branchcode)
LEFT JOIN (
  SELECT items.homebranch AS branch, COUNT(*) as count
  FROM branchtransfers 
  LEFT JOIN items ON (branchtransfers.itemnumber=items.itemnumber) 
  WHERE (items.homebranch != branchtransfers.tobranch)
  AND (items.homebranch != 'ROTATION') 
  AND (branchtransfers.frombranch != branchtransfers.tobranch)
  AND YEAR(datesent) = <<YEAR>>
  GROUP BY items.homebranch ) l ON (l.branch=b.branchcode)
WHERE branchcode NOT IN ("DOWNLOAD", "NEOSHOCC", "ROTATION")
LIMIT 60
  
