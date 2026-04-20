SELECT 
	fassung,
	COUNT(fid) as cnt
FROM {{source('raw_sources', 'src_access_objektdaten')}}
GROUP BY fassung
ORDER BY cnt DESC