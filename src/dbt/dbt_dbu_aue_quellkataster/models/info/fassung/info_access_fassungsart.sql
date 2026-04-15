SELECT 
	fassungsart,
	COUNT(fid) as cnt
FROM {{source('raw_sources', 'access_objektdaten')}}
GROUP BY fassungsart
ORDER BY cnt DESC