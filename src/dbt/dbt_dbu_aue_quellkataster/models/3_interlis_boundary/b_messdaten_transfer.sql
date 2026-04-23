{{ config(
  enabled=var('enable_transfer', false),
  post_hook='{{ transfer_table("dbu_aue_quellkataster", "messdaten") }}'
)}}
-- depends_on: {{ ref('b_quelle_transfer') }}

SELECT 
  *
FROM {{ ref('b_messdaten') }}
