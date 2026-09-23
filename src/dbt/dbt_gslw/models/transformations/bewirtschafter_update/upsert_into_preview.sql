-- depends_on: {{ ref('preview_upserted_bewirtschafter') }}

{{ config(
  enabled= not var('enable_transfer', false), 
  post_hook= '{{
    ili_utils.upsert_into(
      schema_name="dbt_gslw", 
      table_name="preview_upserted_bewirtschafter", 
      conflict_target=["bewirtschafternummer"],
      update_except_cols=[]
    )}}'
) }}

SELECT 
  bewirtschafternummer::character varying, 
  banrede::character varying, 
  bansprech::character varying, 
  bname::character varying, 
  bvorname::character varying, 
  badresse::character varying, 
  bwohnort::character varying, 
  bplz::integer
FROM {{ ref('stg_imp_bew_agricola') }}