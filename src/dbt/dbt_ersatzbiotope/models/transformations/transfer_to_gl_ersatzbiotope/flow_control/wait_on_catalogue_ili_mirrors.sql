-- depends_on: {{ ref('ili_mirror_ersatzmassnahmen_catalogue') }}

{{ config(
  post_hook='ALTER SEQUENCE {{target.schema}}.t_ili2db_seq RESTART WITH 100'
)}}

SELECT 1