-- depends_on: {{ ref('ili_mirror_kt_auengebiet') }}
-- depends_on: {{ ref('ili_mirror_kt_auengebiet_teilobjekt') }}

{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    'TRUNCATE TABLE ch_kt_auengebiete.kt_auengebiet, ch_kt_auengebiete.kt_auengebiet_teilobjekt',
    ili_utils.reset_ili_sequence(
      schema_name="ch_kt_auengebiete",
      starting_value=101
    )
  ]
)}}

SELECT 1