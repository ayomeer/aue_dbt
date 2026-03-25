SELECT 
     fid,
     access_messdaten_schuettungsmenge as schuettungsmenge,
     'Regierungsrat' as behoerde,
     '2003-11-25' as beschluss,
     'Abteilung Umweltschutz und Energie' as datenherr,
     'Uebersichtsplan' as plangrundlage,
     null as bemerkung
FROM {{source('quellobjekte', 'src_access_objektdaten')}}


