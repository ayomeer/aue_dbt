SELECT 
    ST_X(the_geom) as koordinate_e,
    ST_Y(the_geom) as koordinate_n,
    arr_pdf[array_upper(arr_pdf, 1)] as pdf_basename,
    kategorie,
    ablagenummer,
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
    ST_X(r.the_geom) as koordinate_e,
    ST_Y(r.the_geom) as koordinate_n,
    arr_pdf[array_upper(arr_pdf, 1)] as pdf_basename,
    r.kategorie,
    b.ablagenummer,
    r.bohrprofil_pdf,
    r.the_geom as geometrie,
    r.publikation
FROM {{ ref('stg_rueckgabe_h2o') }}  as r
LEFT JOIN {{ ref('stg_konzession') }}  as k
	ON r.id_konzession = k.id
LEFT JOIN  {{ ref('stg_borehole') }}  as b
	ON k.id_borehole = b.id
WHERE typ = 'Bohrung'

