-- depends_on: {{ ref('prepare_target_ch_kt_biotope_flaechen') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_biotope_flaechen", 
      table_name="biotopflaeche"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_biotopflaeche') }}