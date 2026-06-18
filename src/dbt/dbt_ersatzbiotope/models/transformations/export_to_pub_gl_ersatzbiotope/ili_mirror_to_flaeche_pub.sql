{{ config(materialized='table') }}

SELECT 
  nextval('dbt_ersatzbiotope.t_ili2db_seq'::regclass) as t_id,
  '{{ var('baskets')['basket_data']['t_id'] }}'::bigint as t_basket,
  uuid_generate_v4() as t_ili_tid,
  st_area(geometrie)::numeric(12,3) as flaeche_m2,
  geometrie::geometry(MultiPolygon,2056) as geo_obj,
  objekt_nummer::integer,
  teilobjekt_nummer::integer as teilobj_nr,
  kategorie_ersatzmassnahme::character varying(255),
  ersatzmassnahme::character varying(255),
  ziellebensraum::character varying(255),
  entscheide::text
FROM {{ ref('stg_ersatzbiotope_sf') }}