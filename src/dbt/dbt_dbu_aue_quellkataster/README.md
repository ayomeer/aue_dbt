# dbt_dbu_aue_quellkataster

Corresponding INTERLIS model: prod_quellkataster_simple.ili




## TODO
---

- [ ] refactor model names in 'staging' and 'intermediate' layers

### Manual Jobs after populating the prod model

**Dataset merging:**
- [ ] deduplicate
  - QGIS-Layer: Link object(s) within 10m and edit side-by-side

**Hard to map Attributes:**
- [ ] grundwasserleiter_typ [Lockergestein, Kluft, Karst, gemischt, unbestimmt]
- [ ] quelltyp (optional)
  - "Quellfunktionsweise oder Schüttungsverhalten"
- [ ] fassungsart [ungefasst, gefasst]
- [ ] nutzungszustand (wenn gefasst) [genutzt, ungenutzt, aufgehoben, unbestimmt]
- [ ] trinkwasser (wenn gefasst und genutzt)[ja, nein, unbestimmt]
- [ ] zweck (optional) [text]
- [ ] oeffentliches interesse (wenn gefasst und genutzt) [ja, nein, unbestimmt]
- [ ] zustroembereich_erforderlich (wenn fassung im öffentlichen Interesse) [ja, nein, unbestimmt]


**enter manually:**
- [ ] 3 erhebungsdatum entries from csv -> DB
- [ ] Messdaten csv -> DB