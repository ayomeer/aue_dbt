{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="gl_ersatzbiotope", 
      table_name="ersatzmassnahme_catalogue"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_ersatzmassnahmen_catalogue') }}