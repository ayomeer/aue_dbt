SELECT 
	Verwendungsart,
	COUNT(schluessel) as cnt
FROM {{source('raw_sources', 'src_access_objektdaten')}}
GROUP BY Verwendungsart
ORDER BY cnt DESC