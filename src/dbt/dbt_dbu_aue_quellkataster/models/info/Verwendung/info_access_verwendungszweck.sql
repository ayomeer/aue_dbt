SELECT 
	Verwendungszweck,
	COUNT(fid) as cnt
FROM {{source('raw_sources', 'access_objektdaten')}}
GROUP BY Verwendungszweck
ORDER BY cnt DESC