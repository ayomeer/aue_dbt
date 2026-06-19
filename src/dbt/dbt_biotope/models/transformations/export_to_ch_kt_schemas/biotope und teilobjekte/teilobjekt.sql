
SELECT
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id,
  sf.teilobj_nr::varchar(30),
  sf.biotopart,
  sf.geometrie as geo_obj,
  b.t_id as t_id_biotop
FROM {{ ref('stg_biotope_to_sf') }} sf
LEFT JOIN {{ ref('biotop') }} as b
  ON sf.link_key = ANY(b.link_key_array)