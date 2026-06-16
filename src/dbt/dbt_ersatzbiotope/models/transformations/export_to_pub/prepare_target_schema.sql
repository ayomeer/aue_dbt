-- depends_on: {{ ref('ili_mirror_to_flaeche_pub') }}

{{ config(
  materialized='execute_sql',
  enabled=var('enable_transfer', false),
)}}

{{ ili_utils.reset_ili_sequence(target.schema) }}

{{ ili_utils.reset_target_schema('pub_gl_ersatzbiotope') }}