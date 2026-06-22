-- assert, that there are no unexpected types in geometry layers
-- other than the surface layer prod_gl_biotope.biotope_to_sf

SELECT 
	biotopart
FROM prod_gl_biotope.biotope_to_pt
WHERE biotopart <> ALL(array['Artvorkommen', 'Biotopbäume', 'Pilzvorkommen'])

UNION 

SELECT 
	biotopart
FROM prod_gl_biotope.biotope_to_li
WHERE biotopart <> ALL(array['Trockenmauer', 'Hecke'])