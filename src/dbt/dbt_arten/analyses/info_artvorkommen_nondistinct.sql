DROP VIEW orig_prod_gl_arten.duplicates;
CREATE VIEW orig_prod_gl_arten.duplicates AS (
	WITH ranked AS (
	    SELECT
	        MAX(gid) OVER w AS representative_gid,
	        COUNT(*)        OVER w AS duplicate_count,
			a.*
	    FROM orig_prod_gl_arten.artvorkommen_gl_pt a
	    WINDOW w AS (
	        PARTITION BY geometrie, funddatum, art_wiss
	    )
	)

	SELECT 
	*
	FROM ranked
	WHERE duplicate_count > 1
	ORDER BY
		duplicate_count DESC,
		representative_gid,
		gid
)	
