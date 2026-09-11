
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE pub_gl_ersatzbiotope.to_linie',
    ili_utils.reset_ili_sequence(
      schema_name="pub_gl_ersatzbiotope",
      starting_value=var('data_t_id_offset')
    )
  ]
)}}

SELECT 1