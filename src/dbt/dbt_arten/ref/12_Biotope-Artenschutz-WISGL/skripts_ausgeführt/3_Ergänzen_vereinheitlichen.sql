-- Skript Nr. 3 - Datentransfer prod_gl_artvorkommen --> wis
-- Update Roter Lister Status von Arten, welche der RL Status nicht im Katalog erfasst ist.

-- Zusätzliches Update von Schutzstatus CH und Glarus der Barrenringelnatter
-- Stand 09.02.22

-- Der Rote Liste Status könnte man auch direkt im Katalog ändern!

-- Rote Liste Status: Leere Zellen (NULL) von Grünes Gabelzahnmoos werden mit "LC" gefüllt
UPDATE prod_gl_arten.wis_artvorkommen SET rote_liste_status = 'LC'
WHERE (((rote_liste_status) Is Null) AND ((deutscher_name)='Grünes Gabelzahnmoos'));
-- returns 0 records

-- Rote Liste Status: Leere Zellen (NULL) von Tamarisken-Wassersackmoos werden mit "NT" gefüllt
UPDATE prod_gl_arten.wis_artvorkommen SET rote_liste_status = 'NT'
WHERE (((rote_liste_status) Is Null) AND ((deutscher_name)='Tamarisken-Wassersackmoos'));
-- returns 0 records

-- Rote Liste Status: Leere Zellen (NULL) von Hängemoos werden mit "LC" gefüllt
UPDATE prod_gl_arten.wis_artvorkommen SET rote_liste_status = 'LC'
WHERE (((rote_liste_status) Is Null) AND ((deutscher_name)='Hängemoos'));
-- returns 0 records: LC already set in cat_art

-- Schutzstatus CH der Barrenringelnatter anpassen
UPDATE prod_gl_arten.wis_artvorkommen SET schutz_status_schweiz = '451.1/3' 
WHERE deutscher_name='Barrenringelnatter';
-- done

-- Schutzstatus GL der Barrenringelnatter anpassen
UPDATE prod_gl_arten.wis_artvorkommen SET schutz_status_kt_gl = 'ja'
WHERE deutscher_name='Barrenringelnatter';
-- done

-- Namen änder Epipactis helleborine aggr
UPDATE prod_gl_arten.wis_artvorkommen 
	SET deutscher_name = 'Breitblättrige Stendelwurz',
	id_art = 27184
WHERE lateinischer_name = 'Epipactis helleborine';

UPDATE prod_gl_arten.wis_artvorkommen 
	SET lateinischer_name = 'Epipactis helleborine',
	id_art = 27184
WHERE lateinischer_name = 'Epipactis helleborine aggr.';

-- Name änder Natrix natrix aggr.
UPDATE prod_gl_arten.wis_artvorkommen 
	SET lateinischer_name = 'Natrix helvetica',
	deutscher_name = 'Barrenringelnatter',
	id_art = 26436,
	rote_liste_status = 'VU',
	schutz_status_schweiz = '451.1/3',
	schutz_status_kt_gl = 'ja'
WHERE lateinischer_name = 'Natrix natrix aggr.'