SELECT 
	Verwendungsart,
	COUNT(fid) as cnt
FROM {{source('raw_sources', 'access_objektdaten')}}
GROUP BY Verwendungsart
ORDER BY cnt DESC