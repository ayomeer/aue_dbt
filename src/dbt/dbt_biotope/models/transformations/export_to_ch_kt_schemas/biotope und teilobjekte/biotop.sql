	select
    'GL'::varchar
		objekt_nummer,
    min(objekt_name) as aname, -- asserted, that they're all the same in tests
		(SUM(st_area(geometrie)) / 100)::numeric(12,3) as obj_gisflaeche, -- [ha]
    --NULL as au_typ,
    min(herkunft)::varchar(80) as herkunft -- asserted, that they're all the same in tests
    min
  from {{ ref('stg_biotope_to_sf') }}
	group by objekt_nummer
	order by objekt_nummer