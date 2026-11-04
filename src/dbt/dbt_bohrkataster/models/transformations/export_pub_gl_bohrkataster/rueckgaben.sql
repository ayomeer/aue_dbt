SELECT 
    r.id,
    ST_X(r.the_geom) as koordinate_e,
    ST_Y(r.the_geom) as koordinate_n,
    r.arr_pdf[array_upper(r.arr_pdf, 1)] as pdf_basename,
    r.kategorie,
    b.ablagenummer,
    r.bohrprofil_pdf,
    r.the_geom as geometrie,
    r.publikation
FROM {{ ref('stg_rueckgabe_h2o') }}  as r
LEFT JOIN {{ ref('stg_konzession') }} as k
    ON k.id = r.id_konzession
LEFT JOIN (
    SELECT distinct on (id)
        id,
        ablagenummer
    FROM {{ ref('boreholes') }}
) as b
    ON b.id = k.id_borehole
    
WHERE typ IN (
    'Bohrung',
    'Schachtbau',
    'andere'
) 
  AND b.id is not null -- only export 
  AND r.publikation is true

