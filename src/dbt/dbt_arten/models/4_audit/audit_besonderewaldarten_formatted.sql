{{ config(
  enabled=var('enable_audits', false)
)}}

SELECT 
  row_number() over() as fid,
	*
FROM {{ ref('audit_besonderewaldarten') }}
ORDER BY 
  dbt_audit_row_status,
  dbt_audit_surrogate_key,
  dbt_audit_in_a,
  dbt_audit_in_b