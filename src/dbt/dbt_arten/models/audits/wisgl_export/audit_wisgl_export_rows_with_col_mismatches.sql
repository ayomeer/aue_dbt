
{% set cols_to_compare = [
'id_art',
'name_d',
'name_lat',
'organismengruppe',
'schutz_ch',
'schutz_gl',
'roteliste',
'radius',
'genau',
'substrat',
'foerdermassnahmen',
'finder',
'funddatum',
'hinzugefuegt_am',
'kantonsintern',
'verwaltungsintern',
'astatus',
'bemerkungen',
'fotos'
]%}

{{ audit_utils.audit_rows_with_col_mismatched(
	cols_to_compare, 
	ref('audit_wisgl_export_rows')
) }}

