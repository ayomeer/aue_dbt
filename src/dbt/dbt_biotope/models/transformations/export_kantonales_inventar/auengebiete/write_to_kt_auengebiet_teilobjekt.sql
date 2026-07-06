-- depends_on: {{ ref('prepare_target_auengebiete') }}
-- depends_on: {{ ref('write_to_kt_auengebiet') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_auengebiete", 
      table_name="kt_auengebiet_teilobjekt"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_kt_auengebiet_teilobjekt') }}