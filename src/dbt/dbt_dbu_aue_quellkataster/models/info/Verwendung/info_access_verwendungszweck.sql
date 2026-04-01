SELECT 
	Verwendungszweck,
	COUNT(fid) as cnt
FROM {{source('quellobjekte', 'src_access_objektdaten')}}
GROUP BY Verwendungszweck
ORDER BY cnt DESC