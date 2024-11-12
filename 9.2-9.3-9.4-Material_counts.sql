SELECT homebranch,
SUM(CASE WHEN (ccode IN ("AB", "JB")) THEN 1 ELSE 0 END) AS BOOKcount_NA,
SUM(CASE WHEN (ccode IN ("AUD", "MUS") OR permanent_location IN ("%AUD%") OR itype IN ("%AUDIO%")) THEN 1 ELSE 0 END) AS AUDIOcount_92,
SUM(CASE WHEN (ccode IN ("BLU", "DVD", "VHS") OR permanent_location IN ("%VID%") OR itype IN ("%VISUAL%")) THEN 1 ELSE 0 END) AS VIDcount_93,
SUM(CASE WHEN (ccode IN ("DEV", "GAM", "LOT", "MIC", "PER", "SOF", "SPC")) THEN 1 ELSE 0 END) AS OTHERcount_94,
SUM(CASE WHEN (ccode IN ("DEF", "ILL", "ROT", "STT"))THEN 1 ELSE 0 END) AS LIBUSEcount_NA,
SUM(CASE WHEN (ccode IS NULL) THEN 1 ELSE 0 END) AS YouveGotNulls_FIX,
/* DVD/discs SUM(CASE WHEN (ccode IN ("BLU", "DVD") OR permanent_location IN ("%DVD%", "%BLU%")) THEN 1 ELSE 0 END) AS OBSOcount, */
COUNT(*) AS total
FROM items
WHERE YEAR(dateaccessioned) <= <<YYYY>>
AND homebranch NOT IN ('DOWNLOAD', 'ROTATION')
GROUP BY homebranch
LIMIT 100
