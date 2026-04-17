{{ config(
  enable=var('enable_transfer', false),
  post_hook='{{ write_to_interlis("dbu_aue_quellkataster", "quelle") }}'
)}}

SELECT * FROM {{ ref('b_quelle') }}