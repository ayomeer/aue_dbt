-- use with run-operation
-- Writes catalogue values into interlis target model based on values in prod ersatzbiotope_sf table.
-- From there the catalogue can be exported to XML using Model Baker for reusability.
--
-- Usage:
-- dbt run-operation write_kategorie_catalogue
{%- macro write_kategorie_catalogue() -%}

{% set sql %}
TRUNCATE TABLE gl_ersatzbiotope.ersatzmassnahme_catalogue CASCADE;
	
INSERT INTO gl_ersatzbiotope.ersatzmassnahme_catalogue (
	t_basket,
	t_ili_tid,
	kategorie
)
SELECT
	{{ var('export_config')['catalogue_basket_t_id'] }} as t_basket,
	uuid_generate_v4() as t_ili_tid, 
	kategorie_ersatzmassnahme
FROM {{ ref('stg_union_all') }}
GROUP BY kategorie_ersatzmassnahme
ORDER BY kategorie_ersatzmassnahme
{% endset %}

{% do run_query(sql) %}

{%- endmacro %}