SELECT 
	fassungsart,
	COUNT(schluessel) as cnt
FROM {{source('raw_sources', 'src_access_objektdaten')}}
GROUP BY fassungsart
ORDER BY cnt DESC