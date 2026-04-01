SELECT 
	fassung,
	COUNT(fid) as cnt
FROM {{source('quellobjekte', 'src_access_objektdaten')}}
GROUP BY fassung
ORDER BY cnt DESC