{# this model represents access_objektdaten, where  #}

{# create buffer around access objects #}
WITH access_with_buffer AS (
  SELECT 
    access.*,
    ST_buffer(geometrie, 10, 16) as buffer_10m
  FROM {{ ref('intermediate_access_objektdaten') }} as access
)

{# left join alpquellen objects on spatial join: ON ST_within(buffer) #}
SELECT
  access.t_id,
  access.t_basket,
  access.t_ili_tid,
  -- MGDM columns
  'GL_' || access.t_id::varchar as identifikator,
  COALESCE(overlapping.aname, access.aname)::varchar as aname,
  COALESCE(overlapping.grundwasserleiter_typ, access.grundwasserleiter_typ)::varchar as grundwasserleiter_typ,
  COALESCE(overlapping.quelltyp, access.quelltyp)::varchar as quelltyp,
  COALESCE(overlapping.fassungsart, access.fassungsart)::varchar as fassungsart,
  COALESCE(overlapping.nutzungszustand, access.nutzungszustand)::varchar as nutzungszustand,
  COALESCE(overlapping.trinkwasser, access.trinkwasser)::varchar as trinkwasser,
  COALESCE(overlapping.zweck, access.zweck)::varchar as zweck,
  COALESCE(overlapping.oeffentliches_interesse, access.oeffentliches_interesse)::varchar as oeffentliches_interesse,
  COALESCE(overlapping.schuettung_minimal, access.schuettung_minimal)::numeric(9,2) as schuettung_minimal,
  COALESCE(overlapping.schuettung_mittel, access.schuettung_mittel)::numeric(9,2) as schuettung_mittel,
  COALESCE(overlapping.schuettung_maximal, access.schuettung_maximal)::numeric(9,2) as schuettung_maximal,
  NULL::varchar as zustroembereich_erforderlich,
  access.geometrie,
  
  -- internal columns
  access.hoehe::numeric,
  access.notwasserversorgung::varchar,
  access.name_wv::varchar,
  access.ordnungs_nr::varchar,
  access.ortschaft::varchar,
  access.postleitzahl::varchar,
  access.parz_nr::varchar,
  access.lagegenauigkeit::varchar,
  access.schachtueberstand::integer,
  access.fassungsart_beschreibung::varchar,
  access.fassungsabdeckung::varchar,
  access.fassungszustand::varchar,
  access.schachttyp::varchar,
  access.anzahl_zuleitungen::integer,
  access.schloss::boolean,
  access.fassungseigentuemer::varchar,
  access.verwendungsart::varchar,
  access.verwendungszweck_beschreibung::varchar,
  access.wva_nutzung::boolean,
  access.wva_nutzung_ergaenzen::boolean,
  access.wva_nutzung_streichen::boolean,
  access.wva_nutzung_lage_neu::boolean,
  access.datenherkunft::varchar,
  access.aufgenommen_durch::varchar,
  access.erhebungsdatum::date,
  access.feldbegehung::date,
  access.objektbereinigung::date,
  access.schutzzone::varchar,
  access.kontaktperson::varchar,
  access.bemerkungen::varchar
FROM access_with_buffer as access
JOIN LATERAL (
  SELECT * FROM {{ ref('intermediate_alpquellen_overlapping') }} as overlapping
  WHERE overlapping.access_t_id = access.t_id
  ORDER BY overlapping.distance DESC
  LIMIT 1
) as overlapping ON true
