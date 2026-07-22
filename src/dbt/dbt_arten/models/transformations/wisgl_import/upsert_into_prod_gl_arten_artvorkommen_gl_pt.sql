{{ config(
  enabled=var('enable_transfer', false),
  post_hook= '{{
    ili_utils.upsert_into(
      schema_name="prod_gl_arten", 
      table_name="artvorkommen_gl_pt", 
      conflict_target=["geometrie", "funddatum", "art_wiss"],
      update_except_cols=["copyright", "ext_herkunft", "ext_label", "ext_naturzentrum_id"]
    )}}'
) }}

SELECT * FROM {{ ref('mirrormodel_prod_gl_arten_artvorkommen_gl_pt') }}