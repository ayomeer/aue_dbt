-- depends_on: {{ ref('prepare_target_pub_gl_biotope') }}
-- TODO: Any list additional data depencies here !!!

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="pub_gl_biotope", 
      table_name="biotope_linien"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_biotope_linien') }}