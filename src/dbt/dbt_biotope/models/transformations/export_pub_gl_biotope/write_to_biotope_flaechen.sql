-- depends_on: {{ ref('prepare_target_pub_gl_biotope') }}
-- TODO: Any list additional data depencies here !!!

{{ config(
  enabled=false,
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="pub_gl_biotope", 
      table_name="biotope_flaechen"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_biotope_flaechen') }}