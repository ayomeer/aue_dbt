{% macro post_hook_export() -%}

TRUNCATE TABLE ili2pg_schema.quelle;

INSERT INTO ili2pg_schema.quelle (
	identifikator,
	aname
)
VALUES (
	'example-identifikator-2',
	'example-name-2'
)


{%- endmacro %}