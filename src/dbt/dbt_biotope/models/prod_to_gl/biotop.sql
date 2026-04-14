

SELECT
	'GL' as kanton,
	b.objekt_nummer as objekt_nummer,
	b.objekt_name as objekt_name
FROM {{ ref('biotope_agg') }} as b



