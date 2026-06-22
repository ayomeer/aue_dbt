{{ config(materialized='table') }}

SELECT
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id,
  pt.teilobj_nr::varchar(30),
  pt.biotopart,
  pt.geometrie as geo_obj,
  b.t_id as t_id_biotop
FROM {{ ref('stg_biotope_to_pt') }} pt
LEFT JOIN {{ ref('biotope_pt') }}  as b
  ON pt.link_key = ANY(b.link_key_array)