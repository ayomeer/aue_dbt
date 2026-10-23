{{ config(
  enabled=var('enable_transfer', false),
  post_hook='{{ ili_utils.insert_into("prod_gl_quellkataster", "quelle") }}'
)}}

SELECT * FROM {{ ref('b_quelle') }}