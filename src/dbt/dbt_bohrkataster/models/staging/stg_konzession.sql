SELECT 
  id::integer, -- NOT NULL
  datum_amtsblatt::date, 
  erteilt_durch::character varying, 
  vorname_empfaenger::character varying, 
  name_empfaenger::character varying, 
  adresse_empfaenger::character varying, 
  id_borehole::integer, -- NOT NULL
  laufzeit::real, 
  last_modified::timestamp without time zone, 
  entnahme::real, 
  max_leistung::real, 
  max_waermeentnahme::real, 
  max_temperaturdifferenz::real, 
  bemerkungen::text, 
  parz_konz::character varying, 
  ort_empfaenger::character varying, 
  datum_abnahme::date, 
  bemerkungen_abnahme::character varying, 
  verfasser::character varying, 
  versickerung::boolean, 
  wasseruhr::boolean, 
  kreislauftrennung::boolean, 
  datum_eingabe::date, 
  dat_start_laufzeit::date, 
  nutzung::dbu_aue_gsbohrung.dbu_aue_gsbohrung_konzession_nutzung, 
  status::dbu_aue_gsbohrung.dbu_aue_gsbohrung_konzession_status, 
  grundbuch_anlage::dbu_aue_gsbohrung.dbu_aue_gsbohrung_grundbuch
FROM {{ source('dbu_aue_gsbohrung', 'konzession') }}