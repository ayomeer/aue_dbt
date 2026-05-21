SELECT 
  row_number() over () as fid,
  *
FROM {{ ref('intermediate_alpquellen_overlapping') }}