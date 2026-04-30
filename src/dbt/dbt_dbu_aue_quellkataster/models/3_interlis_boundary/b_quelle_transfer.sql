{{ config(
  enabled=var('enable_transfer', false),
  post_hook='{{ ili_utils.transfer_table("dbu_aue_quellkataster", "quelle") }}'
)}}

SELECT * FROM {{ ref('b_quelle') }}