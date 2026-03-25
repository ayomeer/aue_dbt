SELECT 
	Verwendungsart,
	COUNT(fid) as cnt
FROM {{source('quellobjekte', 'src_access_objektdaten')}}
GROUP BY Verwendungsart
ORDER BY cnt DESC