-- depends_on: {{ ref('prepare_target_ch_kt_biotope_linien') }}
-- depends_on: {{ ref('write_to_biotoplinie') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_biotope_linien", 
      table_name="biotoplinie_teilobjekt"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_biotoplinie_teilobjekt') }}