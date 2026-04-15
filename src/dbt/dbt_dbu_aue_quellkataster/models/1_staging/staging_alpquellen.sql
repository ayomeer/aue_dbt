
select
  {{ adapter.quote("fid") }},
  {{ adapter.quote("geom") }},
  {{ adapter.quote("x-koordinaten") }},
  {{ adapter.quote("y_koordinaten") }},
  {{ adapter.quote("hoehe") }},
  {{ adapter.quote("identifikator") }},
  {{ adapter.quote("name") }} as aname,
  {{ adapter.quote("grundwasserleiter_typ") }},
  {{ adapter.quote("quelltyp") }},
  {{ adapter.quote("fassungsart") }},
  {{ adapter.quote("nutzungszustand") }},
  {{ adapter.quote("trinkwasser") }},
  {{ adapter.quote("zweck") }},
  {{ adapter.quote("notwasserversrogung") }},
  {{ adapter.quote("oeffentliches_interesse") }},
  {{ adapter.quote("schuettung_minimal") }},
  {{ adapter.quote("schuettung_mittel") }},
  {{ adapter.quote("schuettung_maximal") }}
from {{ source('raw_sources', 'alpquellen') }}
