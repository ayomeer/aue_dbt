SELECT
  von_quelle,
  MIN(NULLIF(schuettungsmenge, '')::double precision) as schuettung_minimal,
  MAX(NULLIF(schuettungsmenge, '')::double precision) as schuettung_maximal,
  AVG(NULLIF(schuettungsmenge, '')::double precision) as schuettung_mittel
FROM {{ ref('staging_access_messdaten') }}
GROUP BY von_quelle
