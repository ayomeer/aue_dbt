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
FROM {{ ref('audit_besonderewaldarten') }} as a
LEFT JOIN {{ ref('audit_besonderewaldarten_mismatched_cols') }} as m
  ON m.dbt_audit_surrogate_fkey = a.dbt_audit_surrogate_key
