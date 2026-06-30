{{ config(materialized='table') }}

select
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id,
  'GL'::varchar as kanton,
  pt.objekt_nummer,
  pt.objekt_name as aname, -- asserted, that they're all the same in tests
  --NULL as au_typ,
  pt.herkunft::varchar(80) as herkunft, -- asserted, that they're all the same in tests
  pt.kartierungsgrundlage as kartierungsgrundlage, 
  --min(aufnahmedatum)::date as aufnahmedatum,
  --max(intern_letzte_mutation)::date as mutationsdatum,
  --min(intern_mutationsgrund)::text as mutationsgrund,
  bedeutung::varchar, 
  bafu_bio_typ::varchar,
  
  -- added info for splitting and joining biotope into MGDM objects
  pt.biotopart,
  array_agg(gid) as link_key_array
from {{ ref('stg_biotope_to_pt') }} as pt
left join {{ source('ch_kt_auengebiete', 'bedeutung_catalogue') }} as c_bed
  on c_bed.adescription_de = pt.bedeutung
group by objekt_nummer, biotopart, bedeutung, kartierungsgrundlage, herkunft, objekt_name, bafu_bio_typ
having 
  count(distinct objekt_name) = 1 