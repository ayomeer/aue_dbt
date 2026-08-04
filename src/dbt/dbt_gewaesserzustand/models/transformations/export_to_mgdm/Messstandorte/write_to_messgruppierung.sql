-- depends_on: {{ ref('prepare_target_ch_kant_gewaesserzustand_v1_2') }}
-- TODO: Any list additional data depencies here !!!

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="ch_kant_gewaesserzustand_v1_2", 
      table_name="messgruppierung"
    )}}'
  ]
)}}

SELECT * FROM {{ ref('ili_mirror_messgruppierung') }}