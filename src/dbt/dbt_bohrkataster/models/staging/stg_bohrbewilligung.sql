SELECT 
  id::integer, -- NOT NULL
  datum_erteilung::date, 
  erteilt_durch::character varying, 
  vorname_empfaenger::character varying, 
  name_empfaenger::character varying, 
  adresse_empfaenger::character varying, 
  bg_nr::character varying, 
  last_modified::timestamp without time zone, 
  bemerkungen::text, 
  ort_empfaenger::character varying, 
  parz_bew::character varying, 
  verfasser::character varying, 
  status::dbu_aue_gsbohrung.dbu_aue_gsbohrung_bohrbewilligung_status, 
  grundbuch_borehole::dbu_aue_gsbohrung.dbu_aue_gsbohrung_grundbuch, 
  datum_eingabe::date, 
  bohrzweck::dbu_aue_gsbohrung.dbu_aue_gsbohrung_bohrbewilligung_bohrzweck, 
  ausfuehrung::dbu_aue_gsbohrung.dbu_aue_gsbohrung_bohrbewilligung_ausfuehrung, 
  tmp_id1::character varying
FROM {{ source('dbu_aue_gsbohrung', 'bohrbewilligung') }}