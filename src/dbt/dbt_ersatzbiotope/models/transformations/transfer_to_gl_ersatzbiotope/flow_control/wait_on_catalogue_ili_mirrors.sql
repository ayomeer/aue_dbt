-- depends_on: {{ ref('ili_mirror_ersatzmassnahmen_catalogue') }}

{{ config(
  post_hook=[
    ili_utils.reset_ili_sequence(
        schema_name=target.schema,
        starting_value=var("data")["t_id_starting_at"]
    )
  ]
)}}

SELECT 1