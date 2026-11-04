

SELECT * FROM {{ ref('boreholes') }}
UNION
SELECT * FROM {{ ref('rueckgaben') }}

