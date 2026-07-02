{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.reset_target_schema(
      "gl_besonderewaldarten",
      datasets_dict=var("datasets"),
      baskets_dict=var("baskets")
    )}}',
    '{{ ili_utils.insert_into(
      schema_name="gl_besonderewaldarten", 
      table_name="besonderearten",
      truncate_target=true
    )}}'
  ]
)}}

SELECT * FROM {{ ref('mirrormodel_gl_besonderewaldarten_besonderearten') }}