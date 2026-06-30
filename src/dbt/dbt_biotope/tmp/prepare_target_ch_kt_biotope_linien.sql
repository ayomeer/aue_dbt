
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE ch_kt_biotope_linien.biotoplinie, ch_kt_biotope_linien.biotoplinie_teilobjekt',
    ili_utils.reset_ili_sequence(
      schema_name="ch_kt_biotope_linien",
      starting_value=var('data_t_id_offset')
    )
  ]
)}}

SELECT 1