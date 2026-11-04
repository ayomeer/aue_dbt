{{ config(materialized='table') }} 
-- materialize as table, so access to AV gemeindegrenzen layer
-- doesn't go through view, which causes permission issues.

SELECT 
    b.id,
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
LEFT JOIN {{ ref('stg_konzession') }} as k
    ON k.id_borehole = b.id
CROSS JOIN {{ source('ch_av_dm01', 'gemeindegrenze') }} as g

WHERE b.kategorie in (
    'Grundwasserwärmepumpe Entnahme',
    'Grundwasserwärmepumpe Rückgabe',
    'Grundwasserfassung Trinkwasser',
    'Grundwasserfassung Kühlwasser',
    'Grundwasserfassung Brauchwasser',
    'Erdwärmenutzung',
    'Allgemeine Sondierung'
  ) 
  AND
  -- konzession filter
  (
    k.id is null -- no konz (ok)
    OR
    ( -- if there is a konz: 
        k.status = 'erteilt' -- also filters out NULL
        AND
        k.nutzung <> 'andere' -- also filters out NULL
    )
  )
  AND b.kind in (
        'Rammung',
        'Sondierschlitz',
        'Spülbohrung',
        'Kernbohrung',
        'andere' --> z.B. Schachtbauten, wo auch Geologische Infos erhoben 
      )
  AND ST_Within(b.the_geom, g.geometrie)
  AND b.publikation is true