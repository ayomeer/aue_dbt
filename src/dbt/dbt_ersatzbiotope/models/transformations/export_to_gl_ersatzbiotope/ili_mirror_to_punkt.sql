{{ config(materialized='table') }} 

SELECT 
  t_id::bigint, -- NOT NULL
  t_basket::bigint, -- NOT NULL
  t_ili_tid::uuid, 
  geo_obj::geometry(MultiPoint,2056), -- NOT NULL
  teilobj_nr::integer, -- NOT NULL
  kategorie_ersatzmassnahme::bigint, 
  ersatzmassnahme::text, -- NOT NULL
  ziellebensraum::character varying(255), 
  entscheide::text, 
  dokumente::text, 
  von_ersatzbiotop::bigint
FROM {{ ref('stg_ersatzbiotope_pt') }} as pt
left join {{ ref('ili_mirror_ersatzbiotop') }} as ebio
	on pt.objekt_nummer = ebio.objekt_nummer
left join {{ source('gl_ersatzbiotope', 'ersatzmassnahme_catalogue') }} as cat_kategorie
	on cat_kategorie.kategorie = pt.kategorie_ersatzmassnahme