-- Here, we create what corresponds to "Ersatzbiotop"-Object 
-- in gl_ersatzbiotope target schema

	select
		objekt_nummer, entscheide, dokumente, projekttraeger
	from {{ ref('stg_ersatzbiotope_sf') }}
	group by objekt_nummer, entscheide, dokumente, projekttraeger 