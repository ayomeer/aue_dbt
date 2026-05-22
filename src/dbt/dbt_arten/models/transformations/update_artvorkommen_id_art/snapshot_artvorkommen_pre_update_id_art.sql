-- snapshot to compare with in auditing

{{ config(
  materialized='table',
  tags='static',
  post_hook="COMMENT ON TABLE {{this}} IS 'Snapshot from dbt run on {{ get_datetime_string() }}'"
) }}

SELECT
  *
FROM {{ source('src_prod_gl_arten', 'artvorkommen_gl_pt') }}