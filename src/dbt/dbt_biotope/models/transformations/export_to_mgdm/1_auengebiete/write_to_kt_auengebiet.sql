-- depends_on: {{ ref('prepare_target_auengebiete') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_auengebiete", 
      table_name="kt_auengebiet"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_kt_auengebiet') }}