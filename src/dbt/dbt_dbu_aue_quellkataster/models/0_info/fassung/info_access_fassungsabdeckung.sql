SELECT 
	fassungsabdeckung,
	COUNT(fid) as cnt
FROM {{source('raw_sources', 'access_objektdaten')}}
GROUP BY fassungsabdeckung
ORDER BY cnt DESC