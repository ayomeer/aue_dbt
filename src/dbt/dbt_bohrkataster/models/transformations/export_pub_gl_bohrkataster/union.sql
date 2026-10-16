
-- boreholes
SELECT * FROM {{ ref('borehole_types_with_konz') }}
UNION
SELECT * FROM {{ ref('borehole_types_without_konz') }}
 
UNION

-- rueckgaben
SELECT * FROM {{ ref('rueckgaben') }}

