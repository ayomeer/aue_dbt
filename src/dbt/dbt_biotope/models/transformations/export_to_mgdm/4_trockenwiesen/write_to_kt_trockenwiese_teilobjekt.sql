-- depends_on: {{ ref('prepare_target_ch_kt_trockenwiesen') }}
-- depends_on: {{ ref('write_to_kt_trockenwiese') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_trockenwiesen", 
      table_name="kt_trockenwiese_teilobjekt"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_kt_trockenwiese_teilobjekt') }}