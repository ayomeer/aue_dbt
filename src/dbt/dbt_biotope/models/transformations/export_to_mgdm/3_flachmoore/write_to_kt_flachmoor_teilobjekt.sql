-- depends_on: {{ ref('prepare_target_flachmoore') }}
-- depends_on: {{ ref('write_to_kt_flachmoor') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_flachmoore", 
      table_name="kt_flachmoor_teilobjekt"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_kt_flachmoor_teilobjekt') }}