-- depends_on: {{ ref('prepare_target_gl_ersatzbiotope') }}
-- TODO: Any list additional data depencies here !!!

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="gl_ersatzbiotope", 
      table_name="to_punkt"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_to_punkt') }}