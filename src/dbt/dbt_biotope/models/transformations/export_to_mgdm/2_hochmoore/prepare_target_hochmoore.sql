
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE ch_kt_hochmoore.kt_hochmoor CASCADE',
    ili_utils.reset_ili_sequence(
      schema_name="ch_kt_hochmoore",
      starting_value=var('data_t_id_offset')
    )
  ]
)}}

SELECT 1