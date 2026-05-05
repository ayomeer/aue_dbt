{{ config(
  enabled=var('enable_transfer', false),
  post_hook='{{ ili_utils.insert_into("dbu_aue_quellkataster", "quelle") }}'
)}}

SELECT * FROM {{ ref('b_quelle') }}