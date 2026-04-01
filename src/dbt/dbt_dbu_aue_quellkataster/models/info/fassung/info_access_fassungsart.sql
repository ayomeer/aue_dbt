SELECT 
	fassungsart,
	COUNT(fid) as cnt
FROM {{source('quellobjekte', 'src_access_objektdaten')}}
GROUP BY fassungsart
ORDER BY cnt DESC