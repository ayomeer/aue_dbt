
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

	FROM {{ ref('audit_wisgl_export_rows') }}
	WHERE dbt_audit_row_status = 'modified'
	GROUP BY dbt_audit_surrogate_key
),
mismatched_cols_cte as (
	SELECT
		dbt_audit_surrogate_key as dbt_audit_surrogate_fkey,
		{{ mismatched_cols(cols_to_compare) }}
	FROM agg_cte
)

SELECT 
  row_number() over() as fid,
  CASE 
    WHEN dbt_audit_in_a THEN 'old row'
    WHEN dbt_audit_in_b THEN 'new row'
    ELSE 'error'
  END as row_shown,
  *
FROM {{ ref('audit_wisgl_export_rows') }} as a
LEFT JOIN mismatched_cols_cte as m
  ON m.dbt_audit_surrogate_fkey = a.dbt_audit_surrogate_key



