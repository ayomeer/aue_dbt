{% macro reset_ili_sequence(ili_schema) -%}

ALTER SEQUENCE {{ili_schema}}.t_ili2db_seq RESTART WITH 1;

{%- endmacro %}