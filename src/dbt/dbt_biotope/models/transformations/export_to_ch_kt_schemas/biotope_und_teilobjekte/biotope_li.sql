{{ config(materialized='table') }}

select
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id,
  'GL'::varchar as kanton,
  objekt_nummer,
  min(objekt_name) as aname, -- asserted, that they're all the same in tests
  (SUM(st_area(geometrie)) / 100)::numeric(12,3) as obj_gisflaeche, -- [ha]
  --NULL as au_typ,
  min(herkunft)::varchar(80) as herkunft, -- asserted, that they're all the same in tests
  min(kartierungsgrundlage) as kartierungsgrundlage, 
  --min(aufnahmedatum)::date as aufnahmedatum,
  --max(intern_letzte_mutation)::date as mutationsdatum,
  --min(intern_mutationsgrund)::text as mutationsgrund,
  (array_agg(c_bed.adescription_de ORDER BY c_bed.acode ASC))[1]::varchar as bedeutung, -- take highest prio
  
  -- added info for splitting and joining biotope into MGDM objects
  li.biotopart,
  array_agg(link_key) as link_key_array
from {{ ref('stg_biotope_to_li') }} as li
left join {{ ref('stg_bedeutung_catalogue') }} as c_bed
  on c_bed.adescription_de = li.bedeutung
group by objekt_nummer, biotopart
having 
  count(distinct objekt_name) = 1 AND
  count(distinct herkunft) = 1 AND
  count(distinct kartierungsgrundlage) = 1 AND
  count(distinct bedeutung) = 1