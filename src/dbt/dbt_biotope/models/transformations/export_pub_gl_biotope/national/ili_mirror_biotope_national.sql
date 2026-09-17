{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass)::bigint as t_id, -- NOT NULL
  {{ var('pub_gl_biotope_data_basket_t_id') }}::bigint as t_basket, -- NOT NULL
  uuid_generate_v4()::character varying(200) as t_ili_tid, -- generate on insert

  n.biotoptyp::character varying(255), 
  n.objekt_name::character varying(255) as objektname, 
  n.objekt_nummer::character varying(255) as objektnummer, 
  n.teilobjekt_nummer::character varying(255), 
  n.the_geom::geometry(MultiPolygon,2056) as geometrie, -- NOT NULL
  (ST_Area(n.the_geom) / 100)::integer as flaeche_a
FROM {{ ref('stg_biotope_national') }} as n