-- 'TODO' -> von Fachleuten zu befüllen
SELECT
  o.pkey_src,
  ids.t_id as t_id,
  {{ var('baskets')['basket_quellkataster_access']['t_id'] }}::bigint as t_basket,
  uuid_generate_v4() as t_ili_tid, 
  aname,
  'unbestimmt' as grundwasserleiter_typ,
  NULL as quelltyp,
  'TODO' as fassungsart,
  'TODO' as nutzungszustand,
  'TODO' as trinkwasser,
  NULL as zweck,
  NULL as oeffentliches_interesse,
  m.schuettung_minimal,
  m.schuettung_mittel,
  m.schuettung_maximal,
  NULL as zustroembereich_erforderlich,
  geometrie,
  hoehe,
  NULL as notwasserversorgung,
  NULL as name_wv,
  ordnungs_nr,
  ortschaft,
  postleitzahl,
  parz_nr,
  lagegenauigkeit,
  schachtueberstand,
  fassungsart as fassungsart_beschreibung,
  fassungsabdeckung,
  fassungszustand,
  schachttyp,
  anzahl_zuleitungen,
  CASE 
    WHEN schloss = 'ja' THEN true
    WHEN schloss = 'nein' THEN false
    ELSE NULL
  END as schloss,
  fassungseigentuemer,
  verwendungsart,
  verwendungszweck as verwendungszweck_beschreibung,
  CASE 
    WHEN wva_nutzung = 'WAHR' THEN true
    WHEN wva_nutzung = 'FALSCH' THEN false
    ELSE NULL
  END as wva_nutzung,
  CASE 
    WHEN wva_nutzung_ergaenzen = 'WAHR' THEN true
    WHEN wva_nutzung_ergaenzen = 'FALSCH' THEN false
    ELSE NULL
  END as wva_nutzung_ergaenzen,
    CASE 
    WHEN wva_nutzung_streichen = 'WAHR' THEN true
    WHEN wva_nutzung_streichen = 'FALSCH' THEN false
    ELSE NULL
  END as wva_nutzung_streichen,
    CASE 
    WHEN wva_nutzung_lage_neu = 'WAHR' THEN true
    WHEN wva_nutzung_lage_neu = 'FALSCH' THEN false
    ELSE NULL
  END as wva_nutzung_lage_neu,
  datenherkunft,
  aufgenommen_durch,
  erhebungsdatum,
  feldbegehung,
  objektbereinigung,
  schutzzone,
  kontaktperson,
  bemerkungen
FROM {{ ref('staging_access_objektdaten_union') }} as o
LEFT JOIN {{ ref('intermediate_access_objektdaten_ids') }} as ids
  ON ids.pkey_src = o.pkey_src
LEFT JOIN {{ ref('agg_messungen') }} as m
  ON o.pkey_src = m.fkey_quelle_src