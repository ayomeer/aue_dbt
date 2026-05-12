{{ config(
  enabled=var("enable_audits", false)
)}}

SELECT 
  row_number() over() as fid,
  CASE 
    WHEN dbt_audit_in_a THEN 'old row'
    WHEN dbt_audit_in_b THEN 'new row'
    ELSE 'error'
  END as row_shown,
	*
FROM {{ ref('audit_besonderewaldarten') }}
ORDER BY 
  dbt_audit_row_status,
  dbt_audit_surrogate_key,
  dbt_audit_in_a,
  dbt_audit_in_b