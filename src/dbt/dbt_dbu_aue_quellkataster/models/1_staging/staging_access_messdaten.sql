
select
  {{ adapter.quote("fid") }},
  {{ adapter.quote("id") }}::integer as von_quelle,
  {{ adapter.quote("entnahmedatum") }},
  {{ adapter.quote("entnahmezeit") }},
  {{ adapter.quote("witterung") }},
  {{ adapter.quote("schuettungsmenge") }},
  {{ adapter.quote("wassertemperatur") }},
  {{ adapter.quote("truebung") }},
  {{ adapter.quote("elektr_leitfaehigkeit") }},
  {{ adapter.quote("ph-wert") }} as ph_wert,
  {{ adapter.quote("sauerstoff") }},
  {{ adapter.quote("sauerstoffsaettigung") }},
  {{ adapter.quote("chemische_analysen") }},
  {{ adapter.quote("bakteriologische_analysen") }},
  {{ adapter.quote("bemerkungen messdaten") }} as bemerkungen_messdaten 
from {{ source('raw_sources', 'src_access_messdaten') }}
