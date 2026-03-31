-- Select relevant info

SELECT 
  schluessel::character varying(255) as identifikator,
  objektname::character varying(255) as aname,

  as grundwasserleiter_typ character varying(255),
  as quelltyp character varying(255), 
  as fassungsart character varying(255),
  as nutzungszustand character varying(255),
  as trinkwasser character varying(255),
  as zweck character varying(255),
  as oeffentliches_interesse character varying(255),
  as schuettung_minimal numeric(9,2),
  as schuettung_mittel numeric(9,2),
  as schuettung_maximal numeric(9,2),
  as zustroembereich_erforderlich character varying(255),
  as geometrie geometry(Point,2056),
  as name_wv character varying(255)

FROM {{source('quellobjekte', 'src_access_objektdaten')}}

