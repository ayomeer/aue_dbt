-- depends_on: {{ ref('wait_on_catalogue_ili_mirrors') }}

{{ config(materialized='table') }}

select
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
	'{{ var('baskets')['basket_data']['t_id'] }}'::character varying as t_basket,
	uuid_generate_v4() as t_ili_tid,
	st_area(geometrie) as flaeche_m2,
	sf.teilobjekt_nummer as teilobj_nr,
	cat.future_t_id as kategorie_ersatzmassnahme,
	sf.ersatzmassnahme,
	sf.ziellebensraum,
	ebio.t_id as von_ersatzbiotop,
	sf.geometrie as geo_obj
from {{ ref('stg_ersatzbiotope_sf') }} as sf
left join {{ ref('ili_mirror_ersatzbiotop') }} as ebio
	on sf.objekt_nummer = ebio.objekt_nummer
left join {{ ref('stg_cat_kategorie_ersatzmassnahme') }} as cat
	on cat.kategorie_ersatzmassnahme = sf.kategorie_ersatzmassnahme