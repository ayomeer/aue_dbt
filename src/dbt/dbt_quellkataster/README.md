# dbt_quellkataster

Zugehöriges INTERLIS Modell: prod_quellkataster_simple.ili


## Bekannte Probleme

**Erstellung neuer Quellen-Objekte:**
- [ ] 'identifikator'-Feld muss ausgefüllt werden, es wird aber keine ID generiert.


## TODO

### DBT Projekt (Andreas)

- [x] deduplizieren von objekten, welche sowohl in access- als auch in alpquellen Datensatz vorhanden sind
  - MGDM-Attributen mit Werten von Alpquellen-Objekt überschreiben
- [ ] Identifikator-Sequenz einfügen (oder andere Lösung)
  - [ ] trigger-setup?   



### Noch nicht durch dbt Prozess befüllte Informationen 

- [ ] zustroembereich_erforderlich (wenn fassung im öffentlichen Interesse) [ja, nein, unbestimmt]


- [ ] Erhebung / Zusammenführung durch BTG:
  - fassungsart [ungefasst, gefasst]
  - nutzungszustand (wenn gefasst) [genutzt, ungenutzt, aufgehoben, unbestimmt]
  - trinkwasser (wenn gefasst und genutzt)[ja, nein, unbestimmt]
  - oeffentliches interesse (wenn gefasst und genutzt) [ja, nein, unbestimmt]
  - grundwasserleiter_typ [Lockergestein, Kluft, Karst, gemischt, unbestimmt]
  - quelltyp (optional)
    - "Quellfunktionsweise oder Schüttungsverhalten beschreiben"
  - zweck (optional) [text]


**Manuell aus Quelldaten zu Erfassen**
- [ ] 3 erhebungsdatum Attributwerte from csv -> DB
- [ ] Messdaten Nachträge -> DB
  - Excel zu unstrukturiert für automatismus und ohnehin nur ~8 Zeilen
