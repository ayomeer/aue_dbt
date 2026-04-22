
select
  {{ adapter.quote("fid") }},
  ST_Transform({{ adapter.quote("geom") }}, 2056) as geometrie,
  {{ adapter.quote("x_koordinaten") }},
  {{ adapter.quote("y_koordinaten") }},
  {{ adapter.quote("identifikator") }},
  {{ adapter.quote("name") }} as aname,
  {{ adapter.quote("grundwasserleiter_typ") }},
  {{ adapter.quote("quelltyp") }},
  {{ adapter.quote("fassungsart") }},
  {{ adapter.quote("nutzungszustand") }},
  {{ adapter.quote("trinkwasser") }},
  {{ adapter.quote("zweck") }},
  {{ adapter.quote("oeffentliches_interesse") }},
  {{ adapter.quote("schuettung_minimal") }},
  {{ adapter.quote("schuettung_mittel") }},
  {{ adapter.quote("schuettung_maximal") }},
  {{ adapter.quote("hoehe") }},
  {{ adapter.quote("notwasserversorgung") }}
from {{ source('raw_sources', 'src_alpquellen') }}
