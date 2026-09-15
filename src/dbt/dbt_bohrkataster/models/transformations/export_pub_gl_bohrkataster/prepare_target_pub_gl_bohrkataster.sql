
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE pub_gl_bohrkataster.grundwasserbohrung',
    ili_utils.reset_ili_sequence(
      schema_name="pub_gl_bohrkataster",
      starting_value=var('starting_data_tid')
    )
  ]
)}}

SELECT 1