-- depends_on: {{ ref('prepare_target_ch_kt_trockenwiesen') }}
-- TODO: Any list additional data depencies here !!!

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_trockenwiesen", 
      table_name="kt_trockenwiese"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_kt_trockenwiese') }}