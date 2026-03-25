SELECT 
    fid,
    objektname as "Name",
    '?' as "Grundwasserleiter_Typ",
    fassungsart as "Fassungsart",
    verwendungszweck as "Nutzungszustand",
    CASE 
        WHEN verwendungszweck = 'Trinkwasser' THEN 'ja'
        ELSE 'unbestimmt'
    END as "Trinkwasser"
    -- Zweck,
    -- Oeffentliches_Interesse,
    -- Schuettung_minimal,
    -- Schuettung_mittel,
    -- Schuettung_maximal,
    -- Zustroembereich_erforderlich,
    -- Geometrie,
    -- Name_WV,
    -- Ref_GWSZone,
    -- Ref_GSBereich,    
FROM {{source('quellobjekte', 'src_access_objektdaten')}}


