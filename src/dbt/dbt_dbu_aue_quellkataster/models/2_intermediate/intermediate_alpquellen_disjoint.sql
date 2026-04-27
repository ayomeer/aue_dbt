{# this model describes alpquellen, which are NOT near an access_objektdaten 
object and are assumed to be distinct objects new to the dataset. #}

SELECT 
  alpquellen.* 
FROM {{ ref('intermediate_alpquellen') }} as alpquellen
WHERE alpquellen.t_id NOT IN (
  SELECT t_id FROM {{ ref('intermediate_alpquellen_overlapping') }}
)
