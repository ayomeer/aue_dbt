
{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE ch_kt_flachmoore.kt_flachmoor, ch_kt_flachmoore.kt_flachmoor_teilobjekt',
    ili_utils.reset_ili_sequence(
      schema_name="ch_kt_flachmoore",
      starting_value=var('data_t_id_offset')
    )
  ]
)}}

SELECT 1