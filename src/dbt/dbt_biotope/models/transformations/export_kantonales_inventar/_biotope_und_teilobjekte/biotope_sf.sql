{{ config(materialized='table') }}

select
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id,
  'GL'::varchar as kanton,
  objekt_nummer,
  objekt_name as aname, -- asserted, that they're all the same in tests
  ((SUM(st_area(geometrie)) / 100)+1)::numeric(12,3) as obj_gisflaeche, -- [ha], +1 because of wrong value range in INTERLIS model starting at 1.0
  herkunft::varchar(250) as herkunft, -- asserted, that they're all the same in tests
  kartierungsgrundlage, 
  bedeutung::varchar,
  bio_typ_derived::varchar,

  -- added info for splitting and joining biotope into MGDM objects
  sf.biotopart,
  array_agg(gid) as link_key_array
from {{ ref('stg_biotope_to_sf') }} as sf
left join {{ source('ch_kt_auengebiete', 'bedeutung_catalogue') }} as c_bed
  on c_bed.adescription_de = sf.bedeutung
group by 
  objekt_nummer, 
  biotopart, 
  bedeutung,
  kartierungsgrundlage,
  herkunft,
  objekt_name,
  bio_typ_derived 
-- having (SUM(st_area(geometrie)) / 100) > 1.0 -- mgdm constraint: at least 1ha
