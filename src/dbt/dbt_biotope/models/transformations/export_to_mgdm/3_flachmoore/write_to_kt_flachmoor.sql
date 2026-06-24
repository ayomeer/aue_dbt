-- depends_on: {{ ref('prepare_target_flachmoore') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_flachmoore", 
      table_name="kt_flachmoor"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_kt_flachmoor') }}