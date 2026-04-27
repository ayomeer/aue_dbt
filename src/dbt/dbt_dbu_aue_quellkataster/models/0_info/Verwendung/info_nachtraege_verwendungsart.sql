WITH agg as (
	SELECT 
		Verwendungsart,
		COUNT(schluessel) as cnt
	FROM {{source('raw_sources', 'src_nachtraege')}}
	GROUP BY Verwendungsart
	ORDER BY cnt DESC
)
SELECT 	
	Row_Number() OVER() as rank,
	agg.*
FROM agg