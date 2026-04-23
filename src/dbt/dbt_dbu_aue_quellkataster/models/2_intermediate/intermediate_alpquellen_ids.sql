{{ config(materialized='table')}} 
-- materialize as table so nextval doesn't get called multiple times

SELECT 
  pkey_src,
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id
FROM {{ ref('staging_alpquellen') }}