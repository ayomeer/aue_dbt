-- depends_on: {{ ref('prepare_target_ch_kt_amphibien_laichgebiete') }}
-- depends_on: {{ ref('write_to_kt_amphibiengebiet') }}
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_amphibien_laichgebiete", 
      table_name="kt_amphibiengebiet_teilobjekt"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_kt_amphibiengebiet_teilobjekt') }}