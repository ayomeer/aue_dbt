-- depends_on: {{ ref('ili_mirror_kartierungsgrundlage_catalogue') }} 

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    ili_utils.reset_ili_sequence("dbt_biotope"),
    ili_utils.reset_target_schema(
      "ch_kt_auengebiete", 
      datasets_dict=var("datasets")["kt_auengebiete"],
      baskets_dict=var("baskets")["kt_auengebiete"]
    ) 
  ]
)}}

SELECT 1