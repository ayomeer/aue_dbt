{{ config(materialized='table') }} 

SELECT 
  b.t_id::bigint,
  {{ var('data_basket')['t_id'] }}::bigint as t_basket,
  -- t_ili_tid::uuid, (letting this be auto-generated on insert)
  b.kanton::character varying(255),
  b.objekt_nummer::character varying(30) as objnummer,
  b.aname::character varying(80),
  b.obj_gisflaeche::numeric(12,3),
  -- au_typ::bigint,
  b.herkunft::character varying(250),
  kart_cat.t_id::bigint as kartierungsgrundlage,
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
LEFT JOIN {{ source('prod_gl_biotope', 'cat_kartierungsgrundlage') }} as cat_kart 
  ON cat_kart.kartierungsgrundlage = b.kartierungsgrundlage
LEFT JOIN {{ source('ch_kt_auengebiete', 'kartierungsgrundlage_catalogue') }} as kart_cat
  ON kart_cat.acode = cat_kart.code_bund 
LEFT JOIN {{ source('ch_kt_auengebiete', 'bedeutung_catalogue') }} as cat_bedeutung
  ON cat_bedeutung.adescription_de = b.bedeutung
WHERE b.biotopart = 'Auengebiet'

