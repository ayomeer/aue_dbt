{% macro post_hook_export(ili_schema, ili_table) -%}

ALTER SEQUENCE {{ili_schema}}.t_ili2db_seq RESTART WITH 1;
TRUNCATE TABLE {{ili_schema}}.{{ili_table}};

{% set column_names = dbt_utils.get_filtered_columns_in_relation(
  from=source('target', 'quelle'), 
  except=["t_id"]
)%}

INSERT INTO {{ili_schema}}.{{ili_table}} (
-- get columns from db w/ util

)

SELECT 

FROM {{ this }}

{%- endmacro %}