-- depends_on: {{ ref('prepare_target_schema') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="pub_gl_ersatzbiotope", 
      table_name="to_flaeche"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_to_flaeche_pub') }}