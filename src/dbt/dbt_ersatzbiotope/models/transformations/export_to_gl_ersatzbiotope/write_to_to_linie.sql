-- depends_on: {{ ref('_prepare_target_gl_ersatzbiotope') }}
-- depends_on: {{ ref("write_ersatzbiotop_to_target") }}


{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="gl_ersatzbiotope", 
      table_name="to_linie"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_to_linie') }}