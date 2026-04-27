WITH agg as (
	SELECT 
		fassungsart,
		COUNT(schluessel) as cnt
	FROM {{source('raw_sources', 'src_nachtraege')}}
	GROUP BY fassungsart
	ORDER BY cnt DESC
)
SELECT 	
	Row_Number() OVER() as rank,
	agg.*
FROM agg