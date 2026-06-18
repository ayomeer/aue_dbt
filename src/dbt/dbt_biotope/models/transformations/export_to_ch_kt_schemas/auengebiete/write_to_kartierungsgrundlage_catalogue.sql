{{ config(
  enabled=var('enable_transfer', false),
  post_hook=
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_auengebiete", 
      table_name="kartierungsgrundlage_catalogue"
    )}}'
)}}

SELECT * FROM {{ ref('ili_mirror_kartierungsgrundlage_catalogue') }}