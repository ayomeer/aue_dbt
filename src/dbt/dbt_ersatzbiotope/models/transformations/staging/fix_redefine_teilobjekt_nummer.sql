SELECT 
  gid,
  objekt_nummer,
  row_number() over (
    PARTITION BY objekt_nummer 
    ORDER BY objekt_nummer, teilobjekt_nummer
  ) as teilobjekt_nummer,
  ersatzmassnahme,
  kategorie_ersatzmassnahme,
  ziellebensraum,
  flaeche_m2,
  entscheide,
  projekttraeger,
  dokumente,
  bemerkungen_intern,
  geometrie
FROM prod_gl_ersatzbiotope.ersatzbiotope_sf
ORDER BY objekt_nummer, teilobjekt_nummer