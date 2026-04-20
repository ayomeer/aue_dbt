SELECT 
	fassungsart,
	COUNT(fid) as cnt
FROM {{source('raw_sources', 'src_access_objektdaten')}}
GROUP BY fassungsart
ORDER BY cnt DESC