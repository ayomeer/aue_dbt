SELECT 
	fassungsabdeckung,
	COUNT(schluessel) as cnt
FROM {{source('raw_sources', 'src_access_objektdaten')}}
GROUP BY fassungsabdeckung
ORDER BY cnt DESC