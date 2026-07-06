{% docs __overview__ %}

# Overview dbt Projekt dbt_biotope

Dies ist die Dokumentationsseite zu dem dbt Projekt `dbt_biotope`, welches Transformationen rund um das Datenbankschema `prod_gl_biotope` enthält.


## Transformationen
Alle Transformations-Modelle können links im Projekt-Browser unter `dbt_biotope > models > transformations` eingesehen werden. Es sind folgende Tranformations-Jobs definiert (Ctrl+Click für Job-Graph):

- **[export_kantonales_inventar](https://dbt-biotope.netlify.app/#!/overview?g_v=1&g_i=transformations.staging%20transformations.kantonales_inventar):**  
  Exportiert Daten aus `prod_gl_biotope` in die jeweiligen Bundesmodelle für das kantonale Inventar der Biotope:
  - ch_kt_amphibien_laichgebiete
  - ch_kt_amphibien_wanderobjekte (noch keine Daten vorhanden)
  - ch_kt_auengebiete
  - ch_kt_hochmoore
  - ch_kt_flachmoore
  - ch_kt_trockenwiesen
  - ch_kt_biotope_flaechen
  - ch_kt_biotope_linien
  - ch_kt_biotope_punkte

  `export_kantonales_inventar` führt den Export der Biotope in alle respektiven Zielschemas aus. Es können aber auch nur einzelne Zielschemas aktualisiert werden, indem ein subdirectory von `models/export_kantonales_inventar` angegeben wird. Zum Beispiel: 
  
  ```bash
  dbt build -s +transformations.export_kantonales_inventar.flachmoore --vars 'enable_transfer: true'
  ```

## Audits
Für dieses Projket sind keine Audits definiert.


## Verwendung über Windmill
Diese Transformations-Jobs können über die subdirectory-Namen im `models` directory ausgewählt werden, wenn das windmill-Script 'run dbt transform' ausgeführt wird (Argument 'Model Selection').

## Weiterführende Informationen
Details für die Tranformationen können der Graphendarstellung (blauer Knopf unten rechts dieser Seite) und der Dokumentation / Definition der individuellen dbt-Modellen entnommen werden. Dazu die Graphendarstellung im Menüband unten nach dem gewünschten Tag filtern.

{% enddocs %}