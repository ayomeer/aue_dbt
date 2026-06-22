{{ config(materialized='table') }} 

SELECT 
  b.t_id::bigint,
  {{ var('data_basket')['t_id'] }}::bigint as t_basket,
  -- t_ili_tid::uuid, (letting this be auto-generated on insert)
  b.kanton::character varying(255),
  b.objekt_nummer::character varying(30) as objnummer,
  b.aname::character varying(80),
  b.obj_gisflaeche::numeric(12,3),
  b.herkunft::character varying(250),
  cat_kartierung.t_id::bigint as kartierungsgrundlage,
  -- aufnahmedatum::date,
  -- mutationsdatum::date,
  -- mutationsgrund::text,
  -- mutationsgrund_de::text,
  -- mutationsgrund_fr::text,
  -- mutationsgrund_rm::text,
  -- mutationsgrund_it::text,
  -- mutationsgrund_en::text,
  cat_bedeutung.t_id::bigint as bedeutung
FROM {{ ref('biotope_sf') }}  as b
LEFT JOIN {{ ref('stg_kartierungsgrundlage_catalogue') }} as cat_kartierung
  ON cat_kartierung.adescription_de = b.kartierungsgrundlage 
LEFT JOIN {{ ref('stg_bedeutung_catalogue') }} as cat_bedeutung
  ON cat_bedeutung.adescription_de = b.bedeutung
WHERE b.biotopart = 'Hochmoor'
