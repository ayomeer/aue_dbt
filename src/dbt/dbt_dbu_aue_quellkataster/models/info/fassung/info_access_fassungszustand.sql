SELECT 
	fassungszustand,
	COUNT(fid) as cnt
FROM {{source('raw_sources', 'access_objektdaten')}}
GROUP BY fassungszustand
ORDER BY cnt DESC