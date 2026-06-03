{% docs __overview__ %}

# Overview dbt Projekt dbt_ersatzbiotope

Dies ist die Dokumentationsseite zu dem dbt Projekt `dbt_ersatzbiotope`, welches Transformationen rund um das Datenbankschema `prod_gl_ersatzbiotope` enthält.


## Transformationen
Alle Transformations-Modelle können links im Projekt-Browser unter `dbt_ersatzbiotope > models > transformations` eingesehen werden. Es sind folgende Tranformations-Jobs definiert (Ctrl+Click für Job-Graph):

- **[export_to_gl_ersatzbiotope](https://dbt-ersatzbiotope.netlify.app/#!/overview?g_v=1&g_i=%2Btransformations.export_to_gl_ersatzbiotope):**  
  Exportiert Daten aus `prod_gl_ersatzbiotope` in das INTERLIS Schema `gl_ersatzbiotope`.

- **TODO: [export_to_pub]():**
  Exportiert Daten aus `prod_gl_ersatzbiotope` in das pub Schema `pub_ersatzbiotope`.

## Audits
Es sind zur Zeit noch keine Audits definiert


## Verwendung über Windmill
Diese Transformations-Jobs können über die jeweils gleichnamigen Model Tags ausgewählt werden,
wenn das windmill-Script 'run dbt transform' ausgeführt wird (Argument 'Model Selection').

## Weiterführende Informationen
Details für die Tranformationen können der Graphendarstellung (blauer Knopf unten rechts dieser Seite) und der Dokumentation / Definition der individuellen dbt-Modellen entnommen werden. Dazu die Graphendarstellung im Menüband unten nach dem gewünschten Tag filtern.

{% enddocs %}