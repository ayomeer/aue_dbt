	select
    'GL'::varchar
		objekt_nummer,
    min(objekt_name) as aname, -- asserted, that they're all the same in tests
		(SUM(st_area(geometrie)) / 100)::numeric(12,3) as obj_gisflaeche, -- [ha]
    --NULL as au_typ,
    min(herkunft)::varchar(80) as herkunft -- asserted, that they're all the same in tests
  from {{ ref('stg_biotope_to_sf') }}
	group by objekt_nummer
  having 
    count(distinct objekt_name) = 1 AND
    count(distinct herkunft) = 1 AND
    count(distinct kartierungsgrundlage) = 1 AND
    count(distinct bedeutung) = 1
	order by objekt_nummer