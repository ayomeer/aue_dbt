{{ config(materialized='table') }} 

SELECT 
  sf.t_id::bigint, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  '{{ var('data_dataset')['datasetname'] }}'::character varying(200) as t_datasetname, -- NOT NULL
  uuid_generate_v4()::character varying(200) as t_ili_tid,
  sf.kanton::character varying(255), -- NOT NULL
  sf.objekt_nummer::character varying(30) as objnummer, -- NOT NULL
  sf.aname::character varying(80), 
  sf.obj_gisflaeche::numeric(12,3), -- NOT NULL
  sf.herkunft::character varying(250), -- NOT NULL
  cat_kart.t_id::bigint as kartierungsgrundlage,
  -- aufnahmedatum::date, (optional)
  -- mutationsdatum::date, (optional)
  -- mutationsgrund::text, (optional)
  -- mutationsgrund_de::text, (optional)
  -- mutationsgrund_fr::text, (optional)
  -- mutationsgrund_rm::text, (optional)
  -- mutationsgrund_it::text, (optional)
  -- mutationsgrund_en::text, (optional)
  cat_bedeutung.t_id::bigint as bedeutung
FROM {{ ref('biotope_sf') }}  as sf
LEFT JOIN {{ source('ch_kt_trockenwiesen', 'kartierungsgrundlage_catalogue') }} as cat_kart
  ON lower(cat_kart.adescription_de) = lower(split_part(sf.kartierungsgrundlage, ',', 1))
LEFT JOIN {{ source('ch_kt_trockenwiesen', 'bedeutung_catalogue') }} as cat_bedeutung
  ON lower(cat_bedeutung.adescription_de) = lower(sf.bedeutung)
WHERE sf.biotopart IN ('TWW-Magerheuwiese', 'TWW-Magerweide')
