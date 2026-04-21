SELECT 
	fassung,
	COUNT(schluessel) as cnt
FROM {{source('raw_sources', 'src_access_objektdaten')}}
GROUP BY fassung
ORDER BY cnt DESC