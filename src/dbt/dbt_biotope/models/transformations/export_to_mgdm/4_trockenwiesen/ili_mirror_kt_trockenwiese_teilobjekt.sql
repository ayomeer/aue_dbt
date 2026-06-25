{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass)::bigint as t_id,
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  -- t_ili_tid::character varying(200), 
  teilobj_nr::character varying(30), -- NOT NULL
  -- bewertungseinheit::integer, (optional) "analog Bundesinventar, falls vorhanden"
  -- tww_tobj::integer, (optional) "analog Bundesinventar, falls vorhanden"
  ST_Force3D((ST_Dump(geo_obj)).geom)::geometry(PolygonZ,2056) as geo_obj,
  t_id_biotop::bigint as kt_trockenwiese -- NOT NULL
FROM {{ ref('teilobjekte_sf') }}
WHERE biotopart = 'TWW-Magerheuwiese'