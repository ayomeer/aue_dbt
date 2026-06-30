-- depends_on: {{ ref('prepare_target_hochmoore') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_hochmoore", 
      table_name="kt_hochmoor"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_kt_hochmoor') }}