
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE pub_gl_ersatzbiotope.ersatzbiotope_punkte, pub_gl_ersatzbiotope.ersatzbiotope_linien, pub_gl_ersatzbiotope.ersatzbiotope_flaechen',
    ili_utils.reset_ili_sequence(
      schema_name="pub_gl_ersatzbiotope",
      starting_value=var('starting_data_tid')
    )
  ]
)}}

SELECT 1