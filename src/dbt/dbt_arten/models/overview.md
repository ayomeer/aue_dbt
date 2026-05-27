{% docs __overview__ %}

# Overview dbt Projekt dbt_arten

Dies ist die Dokumentationsseite zu dem dbt Projekt `dbt_arten`, welches Transformationen rund um das Datenbankschema `prod_gl_arten` enthält.


## Transformationen
Folgende Tranformations-Jobs sind in diesem Projekt definiert:

- **wisgl_import:**  
  Integriert Daten aus einem WISGL-Export in `prod_gl_arten.artvorkommen_gl_pt`. Der Import muss unter `dbt_arten.imp_wisgl_besonderearten` zur Verfügung stehen.
- **wisgl_export:**   
  Exportiert die für WISGL relevanten besonderen Waldarten aus `prod_gl_arten.artvorkommen_gl_pt` in die Ziel INTERLIS Tabelle `gl_besonderewaldarten.besonderearten`.
- **update_artvorkommen_id_art:**   
  Verknüpft `artvorkommen_gl_pt`-Objekte mit `cat_art`-Art, wo lateinischer name übereinstimmt mit lateinischem name der Art in `cat_art`.


## Verwendung über Windmill
Diese Transformations-Jobs können über die jeweils gleichnamigen Model Tags ausgewählt werden,
wenn das windmill-Script 'run dbt transform' ausgeführt wird (Argument 'Model Selection').

## Weiterführende Informationen
Details für die Tranformationen können der Graphendarstellung (blauer Knopf unten rechts dieser Seite) und der Dokumentation / Definition der individuellen dbt-Modellen entnommen werden. Dazu die Graphendarstellung im Menüband unten nach dem gewünschten Tag filtern.

{% enddocs %}