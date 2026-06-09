
WITH multipolygons as (
	SELECT
		gid,
		(ST_DumpPoints(geometrie)).path as path,
		(ST_DumpPoints(geometrie)).geom as points
	FROM prod_gl_ersatzbiotope.src_ersatzbiotope_sf
	WHERE gid IN (551, 523, 548, 540, 530, 551, 524, 547)
)
SELECT 
	gid,
	path[1] as polygon_nr,
	path[2] as ring_nr,
	path[3] as vertex_nr,
	ST_X(points),
	ST_Y(points)
FROM multipolygons
