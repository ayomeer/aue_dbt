SELECT
  sf.teilobj_nr as teilobj_nr,
  sf.teilobj_name as teilobj_name
FROM {{ source('src_prod_gl_biotope', 'biotope_to_sf') }} as sf