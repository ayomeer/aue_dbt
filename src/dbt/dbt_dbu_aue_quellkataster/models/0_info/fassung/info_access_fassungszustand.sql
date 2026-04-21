SELECT 
	fassungszustand,
	COUNT(schluessel) as cnt
FROM {{source('raw_sources', 'src_access_objektdaten')}}
GROUP BY fassungszustand
ORDER BY cnt DESC