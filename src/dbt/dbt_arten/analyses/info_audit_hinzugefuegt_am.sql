WITH new_rows AS (
	SELECT
		dbt_audit_surrogate_key,
		hinzugefuegt_am
	FROM dbt_arten."audit_besonderewaldarten_final_UAT"
	WHERE dbt_audit_row_status = 'modified' 
		AND mismatch_hinzugefuegt_am
		AND row_shown = 'new row'
)
SELECT 
	a.dbt_audit_surrogate_key,
	a.row_shown,
	a.hinzugefuegt_am,
	n.hinzugefuegt_am as new_hinzugefuegt_am
FROM dbt_arten."audit_besonderewaldarten_final_UAT" as a
LEFT JOIN new_rows as n 
	ON n.dbt_audit_surrogate_key = a.dbt_audit_surrogate_key
WHERE dbt_audit_row_status = 'modified' 
	AND mismatch_hinzugefuegt_am
	AND row_shown = 'old row'
ORDER BY new_hinzugefuegt_am