-- depends_on: {{ ref('prepare_target_pub_gl_ersatzbiotope') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="pub_gl_ersatzbiotope", 
      table_name="ersatzbiotope_linien"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_ersatzbiotope_linien') }}