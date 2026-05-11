{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.reset_target_schema("gl_besonderewaldarten")}}',
    '{{ ili_utils.insert_into(
      schema_name="gl_besonderewaldarten", 
      table_name="besonderearten",
      truncate_target=true
    )}}'
  ]
)}}

SELECT * FROM {{ ref('bdry_wisgl_export') }}