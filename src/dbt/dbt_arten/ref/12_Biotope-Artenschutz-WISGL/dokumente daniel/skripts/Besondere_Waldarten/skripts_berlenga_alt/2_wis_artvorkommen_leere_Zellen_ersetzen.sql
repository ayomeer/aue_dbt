-- Radius: Leere Zellen (NULL) werden mit 99999 gefüllt

UPDATE prod_gl_arten.wis_artvorkommen SET radius = 99999
WHERE (((radius) Is Null));

-- Schutz Status Schweiz: Leere Zellen (NULL) werden mit "nicht geschuetzt" gefüllt

UPDATE prod_gl_arten.wis_artvorkommen SET schutz_status_schweiz = 'nicht geschuetzt'
WHERE (((schutz_status_schweiz) Is Null));

-- Schutz Status Kanton Glarus: Leere Zellen (NULL) werden mit "nicht geschuetzt" gefüllt

UPDATE prod_gl_arten.wis_artvorkommen SET schutz_status_kt_gl = 'nicht geschuetzt'
WHERE (((schutz_status_kt_gl) Is Null));

-- Kantonsintern: Leere Zellen (NULL) werden mit 'false' gefüllt

UPDATE prod_gl_arten.wis_artvorkommen SET kantonsintern = 'false'
WHERE kantonsintern Is Null;

-- Substrat: Leere Zellen (NULL) werden mit "keine Angabe" gefüllt

UPDATE prod_gl_arten.wis_artvorkommen SET substrat = 'keine Angabe'
WHERE (((substrat) Is Null));

-- Der Rote Liste Status könnte man auch direkt im Katalog ändern!
-- Rote Liste Status: Leere Zellen (NULL) von Grünes Gabelzahnmoos werden mit "LC" gefüllt

UPDATE prod_gl_arten.wis_artvorkommen SET rote_liste_status = 'LC'
WHERE (((rote_liste_status) Is Null) AND ((deutscher_name)='Grünes Gabelzahnmoos'));


-- Rote Liste Status: Leere Zellen (NULL) von Tamarisken-Wassersackmoos werden mit "NT" gefüllt

UPDATE prod_gl_arten.wis_artvorkommen SET rote_liste_status = 'NT'
WHERE (((rote_liste_status) Is Null) AND ((deutscher_name)='Tamarisken-Wassersackmoos'));

-- Rote Liste Status: Leere Zellen (NULL) von Hängemoos werden mit "LC" gefüllt

UPDATE prod_gl_arten.wis_artvorkommen SET rote_liste_status = 'LC'
WHERE (((rote_liste_status) Is Null) AND ((deutscher_name)='Hängemoos'));

-- Finder: Leere Zellen (NULL) werden mit "keine Angabe" gefüllt

UPDATE prod_gl_arten.wis_artvorkommen SET finder = 'keine Angabe'
WHERE (((finder) Is Null));
