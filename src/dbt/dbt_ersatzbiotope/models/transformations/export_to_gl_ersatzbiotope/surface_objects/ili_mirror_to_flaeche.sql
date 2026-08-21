{{ config(materialized='table') }}

select
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  '{{ var('export_config')['gl_ersatzbiotope_data_basket_tid'] }}'::bigint as t_basket,
	uuid_generate_v4() as t_ili_tid,
	st_area(geometrie) as flaeche_m2,
	sf.teilobjekt_nummer as teilobj_nr,
	cat_kategorie.t_id as kategorie_ersatzmassnahme,
	sf.ersatzmassnahme,
	sf.ziellebensraum,
	ebio.t_id as von_ersatzbiotop,
	sf.geometrie as geo_obj
from {{ ref('stg_ersatzbiotope_sf') }} as sf
right join {{ ref('ili_mirror_ersatzbiotop') }} as ebio
	on sf.objekt_nummer = ebio.objekt_nummer
left join {{ source('src_gl_ersatzbiotope', 'ersatzmassnahme_catalogue') }} as cat_kategorie
	on cat_kategorie.kategorie = sf.kategorie_ersatzmassnahme