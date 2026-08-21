-- use with run-operation
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