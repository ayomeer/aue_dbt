-- depends_on: {{ ref('preview_bewirtschafter_update') }}

{{ config(
  enabled= not var('enable_transfer', false), 
  post_hook= '{{
    ili_utils.upsert_into(
      schema_name="dbt_gslw", 
      table_name="preview_bewirtschafter_update", 
      conflict_target=["bewirtschafternummer"],
      update_except_cols=["t_basket"]
    )}}'
) }}

SELECT 
  '{{ var('upsert_config_bewirtschafter')['basket_tid'] }}'::bigint as t_basket,
  bewirtschafternummer::character varying, 
  banrede::character varying, 
  bansprech::character varying, 
  bname::character varying, 
  bvorname::character varying, 
  badresse::character varying, 
  bwohnort::character varying, 
  bplz::integer
FROM {{ ref('stg_imp_bew_agricola') }}