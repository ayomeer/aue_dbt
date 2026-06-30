{{ config(materialized='table') }} 

SELECT 
  sf.t_id::bigint, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  -- t_ili_tid::character varying(200), 
  sf.kanton::character varying(255), -- NOT NULL
  sf.objekt_nummer::character varying(30) as objnummer, -- NOT NULL
  sf.aname::character varying(80), 
  cat_bio_typ.t_id::bigint as bio_typ, -- MANDATORY 
  sf.biotopart::character varying(80) as bio_typ_kt, 
  sf.herkunft::character varying(250), -- NOT NULL
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
FROM {{ ref('biotope_sf') }} as sf
LEFT JOIN {{ source('prod_gl_biotope', 'cat_kartierungsgrundlage') }} as cat_kart 
  ON cat_kart.kartierungsgrundlage = sf.kartierungsgrundlage
LEFT JOIN {{ source('ch_kt_biotope_flaechen', 'bio_kartierungsgrundlage_catalogue') }} as kart_cat
  ON kart_cat.acode = cat_kart.code_bund 
LEFT JOIN {{ source('ch_kt_biotope_flaechen', 'bio_bedeutung_catalogue') }} as cat_bedeutung
  ON cat_bedeutung.adescription_de = sf.bedeutung
LEFT JOIN {{ source('ch_kt_biotope_flaechen', 'bio_typ_catalogue') }} as cat_bio_typ
  ON cat_bio_typ.acode = sf.bafu_bio_typ

WHERE biotopart NOT IN (
  'Auengebiet',
  'Hochmoor',
  'Flachmoor',
  'Amphibienlaichgebiet, Kernbereich',
  'Amphibienlaichgebiet',
  'TWW-Magerheuwiese',
  'TWW-Magerweide'
)