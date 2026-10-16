SELECT 
    ST_X(b.the_geom) as koordinate_e,
    ST_Y(b.the_geom) as koordinate_n,
    b.arr_pdf[array_upper(b.arr_pdf, 1)] as pdf_basename,
    b.kategorie,
    b.ablagenummer,
    b.bohrprofil_pdf,
    b.the_geom as geometrie,
    b.publikation
FROM {{ ref('stg_borehole') }} as b
LEFT JOIN {{ ref('stg_bohrbewilligung') }} as bew
    ON bew.id = b.id_bohrbewilligung

WHERE bew.bohrzweck not in ('Wassernutzung', 'Erdwärmenutzung')
  AND kind in (
        'Rammung',
        'Sondierschlitz',
        'Spülbohrung',
        'Kernbohrung'
      )