-- depends_on: {{ ref('prepare_target_ch_kt_biotope_punkte') }}
-- depends_on: {{ ref('write_to_biotoppunkt') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_biotope_punkte", 
      table_name="biotoppunkt_teilobjekt"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_biotoppunkt_teilobjekt') }}