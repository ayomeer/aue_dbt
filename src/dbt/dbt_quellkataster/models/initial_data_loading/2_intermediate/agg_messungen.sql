SELECT
  fkey_quelle_src,
  MIN(NULLIF(schuettungsmenge, '')::double precision) as schuettung_minimal,
  MAX(NULLIF(schuettungsmenge, '')::double precision) as schuettung_maximal,
  AVG(NULLIF(schuettungsmenge, '')::double precision) as schuettung_mittel
FROM {{ ref('staging_access_messdaten') }}
GROUP BY fkey_quelle_src
