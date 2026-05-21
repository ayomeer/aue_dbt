-- Test description
-- Rank audit rows by string length of foerdermassnahmen column
-- and filter for those, where the new row is shorter than old one.

{{ config(tags=['audit_wisgl_export']) }}

with rank_cte AS (
	SELECT 
		dbt_audit_surrogate_key,
		row_shown,
		length(foerdermassnahmen) as len_foerder,
		RANK() OVER(
			PARTITION BY dbt_audit_surrogate_key
			ORDER BY length(foerdermassnahmen) DESC
		) as len_rank,
		foerdermassnahmen
	FROM {{ ref('audit_besonderewaldarten_final_UAT') }} 
	WHERE mismatch_foerdermassnahmen is true
	ORDER BY row_shown
)
SELECT 
	foerdermassnahmen
FROM rank_cte
WHERE len_rank = 2 AND row_shown = 'new_row'
