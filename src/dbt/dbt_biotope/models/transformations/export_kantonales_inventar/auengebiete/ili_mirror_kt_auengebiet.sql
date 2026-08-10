{{ config(materialized='table') }} 

SELECT 
  sf.t_id::bigint,
  {{ var('data_basket')['t_id'] }}::bigint as t_basket,
  '{{ var('data_dataset')['datasetname'] }}'::character varying(200) as t_datasetname, -- NOT NULL
  uuid_generate_v4()::uuid as t_ili_tid,
  sf.kanton::character varying(255),
  sf.objekt_nummer::character varying(30) as objnummer,
  sf.aname::character varying(80),
  sf.obj_gisflaeche::numeric(12,3),
  -- au_typ::bigint,
  sf.herkunft::character varying(250),
  cat_kart.t_id::bigint as kartierungsgrundlage,
  -- aufnahmedatum::date,
  -- mutationsdatum::date,
  -- mutationsgrund::text,
  -- mutationsgrund_de::text,
  -- mutationsgrund_fr::text,
  -- mutationsgrund_rm::text,
  -- mutationsgrund_it::text,
  -- mutationsgrund_en::text,
  cat_bedeutung.t_id::bigint as bedeutung
FROM {{ ref('biotope_sf') }}  as sf
LEFT JOIN {{ source('ch_kt_auengebiete', 'kartierungsgrundlage_catalogue') }} as cat_kart
  ON lower(cat_kart.adescription_de) = lower(split_part(sf.kartierungsgrundlage, ',', 1))
LEFT JOIN {{ source('ch_kt_auengebiete', 'bedeutung_catalogue') }} as cat_bedeutung
  ON lower(cat_bedeutung.adescription_de) = lower(sf.bedeutung)
WHERE sf.biotopart = 'Auengebiet'

