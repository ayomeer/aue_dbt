WITH agg as (
	SELECT 
		fassungszustand,
		COUNT(schluessel) as cnt
	FROM {{source('raw_sources', 'src_access_objektdaten')}}
	GROUP BY fassungszustand
	ORDER BY cnt DESC
)
SELECT 	
	Row_Number() OVER() as rank,
	agg.*
FROM agg