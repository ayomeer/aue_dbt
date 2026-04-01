SELECT 
	fassungszustand,
	COUNT(fid) as cnt
FROM {{source('quellobjekte', 'src_access_objektdaten')}}
GROUP BY fassungszustand
ORDER BY cnt DESC