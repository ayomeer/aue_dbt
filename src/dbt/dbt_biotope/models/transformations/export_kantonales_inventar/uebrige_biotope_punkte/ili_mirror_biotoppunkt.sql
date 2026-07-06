{{ config(materialized='table') }} 

SELECT 
  pt.t_id::bigint, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  '{{ var('data_dataset')['datasetname'] }}'::character varying(200) as t_datasetname, -- NOT NULL
  uuid_generate_v4()::character varying(200) as t_ili_tid,
  pt.kanton::character varying(255), -- NOT NULL
  pt.objekt_nummer::character varying(30) as objnummer, -- NOT NULL
  pt.aname::character varying(80), 
  cat_bio_typ.t_id::bigint as bio_typ, -- MANDATORY 
  pt.biotopart::character varying(80) as bio_typ_kt, 
  pt.herkunft::character varying(250), -- NOT NULL
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
FROM {{ ref('biotope_pt') }} as pt
LEFT JOIN {{ source('prod_gl_biotope', 'cat_kartierungsgrundlage') }} as cat_kart 
  ON cat_kart.kartierungsgrundlage = pt.kartierungsgrundlage
LEFT JOIN {{ source('ch_kt_biotope_punkte', 'bio_kartierungsgrundlage_catalogue') }} as kart_cat
  ON kart_cat.acode = cat_kart.code_bund 
LEFT JOIN {{ source('ch_kt_biotope_punkte', 'bio_bedeutung_catalogue') }} as cat_bedeutung
  ON cat_bedeutung.adescription_de = pt.bedeutung
LEFT JOIN {{ source('ch_kt_biotope_punkte', 'bio_typ_catalogue') }} as cat_bio_typ
  ON cat_bio_typ.acode = 'BIO_TYP7' --> Anderer Biotoptyp