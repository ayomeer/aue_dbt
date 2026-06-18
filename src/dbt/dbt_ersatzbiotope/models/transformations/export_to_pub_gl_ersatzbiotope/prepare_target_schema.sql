{# -- depends_on: {{ ref('ili_mirror_to_flaeche_pub') }} #}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.reset_ili_sequence("dbt_ersatzbiotope") }}',
    '{{ ili_utils.reset_target_schema("pub_gl_ersatzbiotope") }} '
  ]
)}}

SELECT 1