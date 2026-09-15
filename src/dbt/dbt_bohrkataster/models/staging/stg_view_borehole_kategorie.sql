SELECT 
  id_borehole::integer, 
  bohrzweck::dbu_aue_gsbohrung.dbu_aue_gsbohrung_bohrbewilligung_bohrzweck, 
  nutzung::dbu_aue_gsbohrung.dbu_aue_gsbohrung_konzession_nutzung, 
  kategorie::character varying, 
  id_count::bigint
FROM {{ source('dbu_aue_gsbohrung', 'view_borehole_kategorie') }}