{% macro post_hook_export() -%}

TRUNCATE TABLE ili2pg_schema.quelle;

INSERT INTO ili2pg_schema.quelle (
	identifikator,
	aname
)

SELECT 
fid,
"Name"
--FROM dbu_aue_quellkataster.mrt_mgdm
FROM {{ this }}

{%- endmacro %}