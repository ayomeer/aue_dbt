SELECT 
    ST_X(the_geom) as koordinate_e,
    ST_Y(the_geom) as koordinate_n,
    arr_pdf[array_upper(arr_pdf, 1)] as pdf_basename,
    kategorie,
    bohrprofil_pdf,
    the_geom as geometrie,
    publikation
FROM {{ ref('stg_borehole') }} 
WHERE kind in (
    'Rammung',
    'Sondierschlitz',
    'Spülbohrung',
    'Kernbohrung'
)

UNION

SELECT 
    ST_X(the_geom) as koordinate_e,
    ST_Y(the_geom) as koordinate_n,
    arr_pdf[array_upper(arr_pdf, 1)] as pdf_basename,
    kategorie as typ,
    bohrprofil_pdf,
    the_geom as geometrie,
    publikation
FROM {{ ref('stg_rueckgabe_h2o') }} 
-- TODO: Abklären, ob nach 'typ' gefiltert werden soll