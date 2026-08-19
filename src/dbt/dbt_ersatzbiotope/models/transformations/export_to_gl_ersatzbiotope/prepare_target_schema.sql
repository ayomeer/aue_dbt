{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE gl_ersatzbiotope.ersatzbiotop, gl_ersatzbiotope.to_flaeche, gl_ersatzbiotope.to_linie, gl_ersatzbiotope.to_punkt '
  ]
)}}

SELECT true as prepare_target_schema_successful