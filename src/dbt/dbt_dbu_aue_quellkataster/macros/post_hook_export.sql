{% macro post_hook_export(ili_schema, ili_table) -%}

ALTER SEQUENCE {{ili_schema}}.t_ili2db_seq RESTART WITH 1;

TRUNCATE TABLE {{ili_schema}}.{{ili_table}};
INSERT INTO {{ili_schema}}.{{ili_table}} (
	identifikator,
	aname
)

SELECT 
fid,
"Name"
--FROM dbu_aue_quellkataster.mrt_mgdm
FROM {{ this }}

{%- endmacro %}