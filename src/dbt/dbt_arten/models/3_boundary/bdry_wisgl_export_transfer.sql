{{ config(
  enabled=var('enable_transfer', false),
  post_hook='{{ ili_utils.insert_into(
                  "gl_besonderewaldarten", 
                  "besonderearten"
                )}}'
)}}

SELECT * FROM {{ ref('bdry_wisgl_export') }}