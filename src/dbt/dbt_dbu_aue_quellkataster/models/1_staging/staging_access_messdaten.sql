
select
  {{ adapter.quote("daten id") }}::integer as fkey_quelle_src,
  to_date({{ adapter.quote("entnahmedatum") }}, 'DD.MM.YYYY') as entnahmedatum,
  NULLIF(substring({{ adapter.quote("entnahmezeit") }}, 12),'')::time as entnahmezeit,
  {{ adapter.quote("witterung") }},
  NULLIF({{ adapter.quote("schüttungsmenge") }}, '') as schuettungsmenge,
  NULLIF({{ adapter.quote("wassertemperatur") }}, '') as wassertemperatur,
  {{ adapter.quote("trübung") }} as truebung,
  {{ adapter.quote("elektr leitfähigkeit") }} as elektr_leitfaehigkeit,
  {{ adapter.quote("ph-wert") }} as ph_wert,
  {{ adapter.quote("sauerstoff") }},
  {{ adapter.quote("sauerstoffsättigung") }} as sauerstoffsaettigung,
  {{ adapter.quote("chemische analysen") }} as chemische_analysen,
  {{ adapter.quote("bakteriologische analysen") }} as bakteriologische_analysen,
  {{ adapter.quote("bemerkungen messdaten") }} as bemerkungen 
from {{ source('raw_sources', 'src_access_messdaten') }}
