
{{ dbt_utils.union_relations(
    relations=[
      ref('stg_ersatzbiotope_sf'), 
      ref('stg_ersatzbiotope_li'),
      ref('stg_ersatzbiotope_pt')
    ],
    column_override={
      "geometrie_sf": "geometry(MultiPolygon, 2056)",
      "geometrie_li": "geometry(MultiLineString, 2056)",
      "geometrie_pt": "geometry(MultiPoint, 2056)"
    },
    exclude=[
      "isvalid"
    ]
)}}
