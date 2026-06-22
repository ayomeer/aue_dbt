-- depends_on: {{ ref('prepare_target_hochmoore') }}
-- depends_on: {{ ref('write_to_kt_hochmoor') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kt_hochmoore", 
      table_name="kt_hochmoor_teilobjekt"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_kt_hochmoor_teilobjekt') }}