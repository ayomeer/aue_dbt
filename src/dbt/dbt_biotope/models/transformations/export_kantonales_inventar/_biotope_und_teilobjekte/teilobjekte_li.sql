{{ config(materialized='table') }}

SELECT
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id,
  li.oid_uuid,
  li.teilobj_nr::varchar(30),
  li.biotopart,
  li.geometrie as geo_obj,
  b.t_id as t_id_biotop
FROM {{ ref('stg_biotope_to_li') }} li
LEFT JOIN {{ ref('biotope_li') }}  as b
  ON li.gid = ANY(b.link_key_array)