-- Create t_ili2db_sequence
-- intended use: first time dbt schema setup
--  call through run-operations e.g.:
--  dbt run-operation create_ili_sequence --args '{schema: dbt_quellkataster}'

{% macro create_ili_sequence(schema) -%}
  -- create sequence
  {% set query %}
    CREATE SEQUENCE IF NOT EXISTS {{schema}}.t_ili2db_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
  {% endset %}
  {% set query_return = run_query(query) %}

{%- endmacro %}