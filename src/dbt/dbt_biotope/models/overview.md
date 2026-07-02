{% docs __overview__ %}

# Overview dbt Projekt dbt_biotope

Dies ist die Dokumentationsseite zu dem dbt Projekt `dbt_biotope`, welches Transformationen rund um das Datenbankschema `prod_gl_biotope` enthält.


## Transformationen
Alle Transformations-Modelle können links im Projekt-Browser unter `dbt_biotope > models > transformations` eingesehen werden. Es sind folgende Tranformations-Jobs definiert (Ctrl+Click für Job-Graph):

- **[export_to_mgdm](https://dbt-ersatzbiotope.netlify.app/#!/overview?g_v=1&g_i=%2Btransformations.export_to_gl_ersatzbiotope):**  
  Exportiert Daten aus `prod_gl_ersatzbiotope` in das INTERLIS Schema `gl_ersatzbiotope`.



## Audits
Es sind zur Zeit noch keine Audits definiert


## Verwendung über Windmill
Diese Transformations-Jobs können über die jeweils gleichnamigen Model Tags ausgewählt werden,
wenn das windmill-Script 'run dbt transform' ausgeführt wird (Argument 'Model Selection').

## Weiterführende Informationen
Details für die Tranformationen können der Graphendarstellung (blauer Knopf unten rechts dieser Seite) und der Dokumentation / Definition der individuellen dbt-Modellen entnommen werden. Dazu die Graphendarstellung im Menüband unten nach dem gewünschten Tag filtern.

{% enddocs %}