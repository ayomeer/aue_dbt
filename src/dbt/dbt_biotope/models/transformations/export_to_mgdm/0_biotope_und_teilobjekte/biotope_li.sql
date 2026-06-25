{{ config(materialized='table') }}

select
  nextval('{{target.schema}}.t_ili2db_seq'::regclass) as t_id,
  'GL'::varchar as kanton,
  objekt_nummer,
  objekt_name as aname, -- asserted, that they're all the same in tests
  --NULL as au_typ,
  herkunft::varchar(80) as herkunft, -- asserted, that they're all the same in tests
  kartierungsgrundlage as kartierungsgrundlage, 
  --min(aufnahmedatum)::date as aufnahmedatum,
  --max(intern_letzte_mutation)::date as mutationsdatum,
  --min(intern_mutationsgrund)::text as mutationsgrund,
  bedeutung::varchar, 
  
  -- added info for splitting and joining biotope into MGDM objects
  li.biotopart,
  array_agg(link_key) as link_key_array
from {{ ref('stg_biotope_to_li') }} as li
left join {{ source('ch_kt_auengebiete', 'bedeutung_catalogue') }} as c_bed
  on c_bed.adescription_de = li.bedeutung
group by objekt_nummer, biotopart, bedeutung, kartierungsgrundlage, herkunft, objekt_name
having 
  count(distinct objekt_name) = 1 