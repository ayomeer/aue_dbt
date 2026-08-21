-- use with run-operation
-- Writes catalogue values into interlis target model based on values in prod ersatzbiotope_sf table.
-- From there the catalogue can be exported to XML using Model Baker for reusability.

{%- macro write_kategorie_catalogue(catalogues_basket_t_id) -%}

{% set sql %}
TRUNCATE TABLE gl_ersatzbiotope.ersatzmassnahme_catalogue CASCADE;
	
INSERT INTO gl_ersatzbiotope.ersatzmassnahme_catalogue (
	t_basket,
	t_ili_tid,
	kategorie
)
SELECT
	{{ catalogues_basket_t_id }},
	uuid_generate_v4(), -- t_ili_tid
	kategorie_ersatzmassnahme
FROM prod_gl_ersatzbiotope.ersatzbiotope_sf
GROUP BY kategorie_ersatzmassnahme
ORDER BY kategorie_ersatzmassnahme
{% endset %}

{% do run_query(sql) %}

{%- endmacro %}