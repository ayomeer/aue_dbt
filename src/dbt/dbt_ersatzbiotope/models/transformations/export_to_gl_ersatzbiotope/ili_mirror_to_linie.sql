{{ config(materialized='table') }} 

SELECT 
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  '{{ var('export_config')['gl_ersatzbiotope_data_basket_tid'] }}'::bigint as t_basket,
	uuid_generate_v4() as t_ili_tid,
  ST_Length(li.geometrie_li)::integer as laenge_m, 
  li.geometrie_li::geometry(MultiLineString,2056) as geo_obj, -- NOT NULL
  li.teilobjekt_nummer::integer as teilobj_nr, -- NOT NULL
  cat_kategorie.t_id::bigint as kategorie_ersatzmassnahme, 
  li.ersatzmassnahme::text, -- NOT NULL
  li.ziellebensraum::character varying(255), 
  li.entscheide::text, 
  li.dokumente::text, 
  ebio.t_id::bigint as von_ersatzbiotop
FROM {{ ref('stg_ersatzbiotope_li') }} as li
left join {{ ref('ili_mirror_ersatzbiotop') }} as ebio
	on li.objekt_nummer = ebio.objekt_nummer
left join {{ source('gl_ersatzbiotope', 'ersatzmassnahme_catalogue') }} as cat_kategorie
	on cat_kategorie.kategorie = li.kategorie_ersatzmassnahme