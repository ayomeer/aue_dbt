{{ config(
  enabled=var('enable_transfer', false),
  post_hook='{{ transfer_table("dbu_aue_quellkataster", "messdaten") }}'
)}}

SELECT 
  *
FROM {{ ref('b_messdaten') }}
