
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE gl_ersatzbiotope.ersatzbiotop, gl_ersatzbiotope.to_flaeche, gl_ersatzbiotope.to_linie, gl_ersatzbiotope.to_punkt',
    ili_utils.reset_ili_sequence(
      schema_name="gl_ersatzbiotope",
      starting_value=var('data_t_id_offset')
    )
  ]
)}}

SELECT 1