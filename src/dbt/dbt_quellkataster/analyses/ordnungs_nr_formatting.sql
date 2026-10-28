SELECT 
    t_id,
    ordnungs_nr,
    substring(ordnungs_nr, 0, 4) as xxx,
    substring(ordnungs_nr, 4, 3) as yyy,
    substring(ordnungs_nr, 7, 2) as nn
FROM prod_gl_quellkataster.quelle