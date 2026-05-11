
{% set cols_to_compare = [
'id_art',
'name_d',
'name_lat',
'organismengruppe',
'schutz_ch',
'schutz_gl',
'roteliste',
'radius',
'genau',
'substrat',
'foerdermassnahmen',
'finder',
'funddatum',
'hinzugefuegt_am',
'kantonsintern',
'verwaltungsintern',
'astatus',
'bemerkungen',
'fotos'
]%}

WITH agg_cte as (
	SELECT 
		dbt_audit_surrogate_key,
		{{ aggregate_cols(cols_to_compare) }}

	FROM {{ ref('audit_besonderewaldarten') }}
	WHERE dbt_audit_row_status = 'modified'
	GROUP BY dbt_audit_surrogate_key
)
SELECT
	dbt_audit_surrogate_key as dbt_audit_surrogate_fkey,
	{{ mismatched_cols(cols_to_compare) }}
FROM agg_cte


