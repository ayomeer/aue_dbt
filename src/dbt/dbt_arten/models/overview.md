{% docs __overview__ %}

# Overview dbt Projekt dbt_arten

Dies ist die Dokumentationsseite zu dem dbt Projekt `dbt_arten`, welches Transformationen rund um das Datenbankschema `prod_gl_arten` enthält.


## Transformationen
Alle Transformations-Modelle können links im Projekt-Browser unter `dbt_ersatzbiotope > models > transformations` eingesehen werden. Es sind folgende Tranformations-Jobs definiert (Ctrl+Click für Job-Graph):

- **[transformations.wisgl_import](https://dbt-arten.netlify.app/#!/overview?g_v=1&g_i=%2Btag:wisgl_import):**  
  Integriert Daten aus einem WISGL-Export in `prod_gl_arten.artvorkommen_gl_pt`. Der Import muss unter `dbt_arten.imp_wisgl_besonderearten` zur Verfügung stehen.
- **[transformations.wisgl_export](https://dbt-arten.netlify.app/#!/overview?g_v=1&g_i=%2Btag:wisgl_export):**   
  Exportiert die für WISGL relevanten besonderen Waldarten aus `prod_gl_arten.artvorkommen_gl_pt` in die Ziel INTERLIS Tabelle `gl_besonderewaldarten.besonderearten`.
- **[transformations.update_artvorkommen_id_art](https://dbt-arten.netlify.app/#!/overview?g_v=1&g_i=%2Btag:update_artvorkommen_id_art):**   
  Verknüpft `artvorkommen_gl_pt`-Objekte mit `cat_art`-Art, wo lateinischer name übereinstimmt mit lateinischem name der Art in `cat_art`.


## Audits

Zur Kontrolle der Richtigkeit der Transformationen stehen jeweils Audit-Jobs zur Verfügung. Es wird jeweils ein Zeilenbasierter Audit (`audit_<job_name>_rows`) erstellt, sowie ein Spaltenbasierter Audit (`audit_<job_name>_cols`).




## Verwendung über Windmill
Diese Transformations-Jobs können über die jeweils gleichnamigen Model Tags ausgewählt werden,
wenn das windmill-Script 'run dbt transform' ausgeführt wird (Argument 'Model Selection').

## Weiterführende Informationen
Details für die Tranformationen können der Graphendarstellung (blauer Knopf unten rechts dieser Seite) und der Dokumentation / Definition der individuellen dbt-Modellen entnommen werden. Dazu die Graphendarstellung im Menüband unten nach dem gewünschten Tag filtern.

{% enddocs %}