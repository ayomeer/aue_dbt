WITH agg as (
	SELECT 
		Verwendungszweck,
		COUNT(schluessel) as cnt
	FROM {{source('raw_sources', 'src_nachtraege')}}
	GROUP BY Verwendungszweck
	ORDER BY cnt DESC
)
SELECT 	
	Row_Number() OVER() as rank,
	agg.*
FROM agg