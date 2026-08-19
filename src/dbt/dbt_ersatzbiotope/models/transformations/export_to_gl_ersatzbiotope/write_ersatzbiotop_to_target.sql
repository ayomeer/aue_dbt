-- depends_on: {{ ref('prepare_target_schema') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="gl_ersatzbiotope", 
      table_name="ersatzbiotop"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_ersatzbiotop') }}