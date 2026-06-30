{{ config(materialized='table') }} 

SELECT 
  nextval('{{target.schema}}.t_ili2db_seq'::regclass)::bigint as t_id,
  {{ var('data_basket')['t_id'] }}::bigint as t_basket, -- NOT NULL
  oid_uuid::character varying(200) as t_ili_tid, 
  teilobj_nr::character varying(30), -- NOT NULL
  ST_Force3D((ST_Dump(geo_obj)).geom)::geometry(PointZ,2056) as geo_obj,
  t_id_biotop::bigint as biotop -- NOT NULL
FROM {{ ref('teilobjekte_pt') }}