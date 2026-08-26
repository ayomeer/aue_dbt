{{ config(materialized='table') }} 


WITH bio_typ_default AS (
  SELECT t_id
  FROM {{ source('ch_kt_biotope_flaechen', 'bio_typ_catalogue') }}
  WHERE acode = 'BIO_TYP7'
),
bio_bedeutung_default AS (
  SELECT t_id
  FROM {{ source('ch_kt_biotope_flaechen', 'bio_bedeutung_catalogue') }}
  WHERE adescription_de = 'Regional'
)

SELECT 
  sf.t_id::bigint, -- NOT NULL
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  '{{ var('data_dataset')['datasetname'] }}'::character varying(200) as t_datasetname, -- NOT NULL
  uuid_generate_v4()::character varying(200) as t_ili_tid,
  sf.kanton::character varying(255), -- NOT NULL
  sf.objekt_nummer::character varying(30) as objnummer, -- NOT NULL
  sf.aname::character varying(80), 
  COALESCE(
    cat_bio_typ.t_id, 
    bio_typ_default.t_id
  )::bigint as bio_typ, -- MANDATORY 
  sf.biotopart::character varying(80) as bio_typ_kt, 
  sf.herkunft::character varying(250), -- NOT NULL
  cat_kart.t_id::bigint as kartierungsgrundlage, 
  -- aufnahmedatum::date, 
  -- mutationsdatum::date, 
  -- mutationsgrund::text, 
  -- mutationsgrund_de::text, 
  -- mutationsgrund_fr::text, 
  -- mutationsgrund_rm::text, 
  -- mutationsgrund_it::text, 
  -- mutationsgrund_en::text, 
  COALESCE(
    cat_bedeutung.t_id,
    bio_bedeutung_default.t_id
  )::bigint as bedeutung
FROM {{ ref('biotope_sf') }} as sf
LEFT JOIN {{ source('ch_kt_biotope_flaechen', 'bio_kartierungsgrundlage_catalogue') }} as cat_kart
  ON lower(cat_kart.adescription_de) = lower(sf.kartierungsgrundlage)
LEFT JOIN {{ source('ch_kt_biotope_flaechen', 'bio_bedeutung_catalogue') }} as cat_bedeutung
  ON lower(cat_bedeutung.adescription_de) = lower(sf.bedeutung)
LEFT JOIN {{ source('ch_kt_biotope_flaechen', 'bio_typ_catalogue') }} as cat_bio_typ
  ON cat_bio_typ.acode = sf.bio_typ_derived
CROSS JOIN bio_typ_default
CROSS JOIN bio_bedeutung_default

WHERE biotopart NOT IN (
  'Auengebiet',
  'Hochmoor',
  'Flachmoor',
  'Amphibienlaichgebiet, Kernbereich',
  'Amphibienlaichgebiet',
  'TWW-Magerheuwiese',
  'TWW-Magerweide',
  'Pufferzone',
  'Eventuell schutzwürdiger Lebensraum'
)