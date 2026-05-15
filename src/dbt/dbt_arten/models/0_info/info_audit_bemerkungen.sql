WITH new_rows AS (
	SELECT
		dbt_audit_surrogate_key,
		bemerkungen
	FROM dbt_arten."audit_besonderewaldarten_final_UAT"
	WHERE dbt_audit_row_status = 'modified' 
		AND row_shown = 'new row'
),
sidebyside as (
	SELECT 
		a.dbt_audit_surrogate_key,
		a.row_shown,
		a.bemerkungen,
		n.bemerkungen as new_bemerkungen
	FROM dbt_arten."audit_besonderewaldarten_final_UAT" as a
	LEFT JOIN new_rows as n 
		ON n.dbt_audit_surrogate_key = a.dbt_audit_surrogate_key
	WHERE dbt_audit_row_status = 'modified' 
		AND row_shown = 'old row'
	ORDER BY new_bemerkungen
)
SELECT * FROM sidebyside
WHERE bemerkungen is null AND new_bemerkungen is not null
