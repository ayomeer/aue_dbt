{{ config(materialized='table') }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::uuid, 
  laenge_m::integer, 
  geo_obj::geometry(MultiLineString,2056), -- NOT NULL
  teilobj_nr::integer, -- NOT NULL
  kategorie_ersatzmassnahme::bigint, 
  ersatzmassnahme::text, -- NOT NULL
  ziellebensraum::character varying(255), 
  entscheide::text, 
  dokumente::text, 
  von_ersatzbiotop::bigint
FROM {{ ref('stg_ersatzbiotope_li') }} as li
left join {{ ref('ili_mirror_ersatzbiotop') }} as ebio
	on li.objekt_nummer = ebio.objekt_nummer
left join {{ source('gl_ersatzbiotope', 'ersatzmassnahme_catalogue') }} as cat_kategorie
	on cat_kategorie.kategorie = li.kategorie_ersatzmassnahme