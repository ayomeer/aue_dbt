{{ config(materialized='table') }} 

SELECT 
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  '{{ var('export_config')['gl_ersatzbiotope_data_basket_tid'] }}'::bigint as t_basket,
	uuid_generate_v4() as t_ili_tid,
  pt.geometrie_pt::geometry(MultiPoint,2056) as geo_obj, -- NOT NULL
  pt.teilobjekt_nummer::integer as teilobj_nr, -- NOT NULL
  cat_kategorie.t_id::bigint as kategorie_ersatzmassnahme, 
  pt.ersatzmassnahme::text, -- NOT NULL
  pt.ziellebensraum::character varying(255), 
  pt.entscheide::text, 
  pt.dokumente::text, 
  ebio.t_id::bigint as von_ersatzbiotop
FROM {{ ref('stg_ersatzbiotope_pt') }} as pt
left join {{ ref('ili_mirror_ersatzbiotop') }} as ebio
	on pt.objekt_nummer = ebio.objekt_nummer
left join {{ source('gl_ersatzbiotope', 'ersatzmassnahme_catalogue') }} as cat_kategorie
	on cat_kategorie.kategorie = pt.kategorie_ersatzmassnahme