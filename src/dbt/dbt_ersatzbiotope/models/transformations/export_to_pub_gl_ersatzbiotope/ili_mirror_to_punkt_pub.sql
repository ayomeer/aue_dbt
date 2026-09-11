{{ config(materialized='table') }} 

SELECT 
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  '{{ var('export_config_pub')['data_basket_tid'] }}'::bigint as t_basket,
  uuid_generate_v4() as t_ili_tid,
  geometrie_pt::geometry(MultiPoint,2056) as geo_obj, -- NOT NULL
  objekt_nummer::integer, -- NOT NULL
  teilobjekt_nummer::integer as teilobj_nr, -- NOT NULL
  kategorie_ersatzmassnahme::character varying(255), 
  ziellebensraum::character varying(255), 
  entscheide::text
FROM {{ ref('stg_ersatzbiotope_pt') }}