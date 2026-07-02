{{ config(materialized='table') }} 


SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass)::bigint as t_id, -- re-assign, because of geom dump
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  '{{ var('data_dataset')['datasetname'] }}'::character varying(200) as t_datasetname, -- NOT NULL
  (CASE 
    WHEN ST_NumGeometries(geo_obj) = 1 THEN oid_uuid -- use same uuid as already assigned in source data
    ELSE uuid_generate_v4() -- generate new uuid if more than one Polygon in MultiPolygon
  END)::character varying(200) as t_ili_tid, -- can't use oid_uuid, because of geom dump -> not unique anymore
  teilobj_nr::character varying(30), -- NOT NULL
  -- bewertungseinheit::integer, (optional) "analog Bundesinventar, falls vorhanden"
  -- tww_tobj::integer, (optional) "analog Bundesinventar, falls vorhanden"
  ST_Force3D((ST_Dump(geo_obj)).geom)::geometry(PolygonZ,2056) as geo_obj,
  t_id_biotop::bigint as kt_trockenwiese -- NOT NULL
FROM {{ ref('teilobjekte_sf') }}
WHERE biotopart IN ('TWW-Magerheuwiese', 'TWW-Magerweide')
