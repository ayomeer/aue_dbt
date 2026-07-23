{{ config(enabled=false) }}

SELECT 
  old.id as old_id,
  new.id as new_id,
  row_number() over() as audit_link_id 
FROM {{ ref('stg_imp_wisgl_besonderearten') }} as old
  JOIN {{ ref('stg_besonderearten') }} as new
  ON ST_AsEWKB(old.geometrie) = ST_AsEWKB(new.geometrie) AND
     old.funddatum = new.funddatum AND
     old.name_lateinisch = new.name_lateinisch
  