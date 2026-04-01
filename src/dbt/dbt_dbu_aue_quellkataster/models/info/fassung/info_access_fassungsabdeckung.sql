SELECT 
	fassungsabdeckung,
	COUNT(fid) as cnt
FROM {{source('quellobjekte', 'src_access_objektdaten')}}
GROUP BY fassungsabdeckung
ORDER BY cnt DESC