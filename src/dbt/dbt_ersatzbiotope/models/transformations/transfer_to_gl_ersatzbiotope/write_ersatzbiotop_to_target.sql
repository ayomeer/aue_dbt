{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.reset_target_schema("gl_ersatzbiotope")}}',
    '{{ ili_utils.insert_into(
      schema_name="gl_ersatzbiotope", 
      table_name="ersatzbiotop",
      truncate_target=true
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_ersatzbiotop') }}