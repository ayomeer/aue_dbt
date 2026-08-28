
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE pub_gl_biotope.biotope_linien, pub_gl_biotope.biotope_punkte, pub_gl_biotope.chcantoncode, pub_gl_biotope.biotope_flaechen, pub_gl_biotope.hochlagenbiotope',
    ili_utils.reset_ili_sequence(
      schema_name="pub_gl_biotope",
      starting_value=var('data_t_id_offset')
    )
  ]
)}}

SELECT 1