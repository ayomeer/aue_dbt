-- depends_on: {{ ref('<prepare_target>') }}


{{ config(
  enabled=var('enable_transfer', false),
  post_hook=[
    '{{ ili_utils.insert_into(
      schema_name="<target_schema>", 
      table_name="<target_table>",
      truncate_target=false
    )}}'
  ]
)}}

SELECT * FROM {{ ref('<ili_mirror>') }}