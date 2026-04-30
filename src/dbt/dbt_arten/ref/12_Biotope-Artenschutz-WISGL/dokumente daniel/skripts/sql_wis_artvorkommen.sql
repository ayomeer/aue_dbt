INSERT INTO gl_waldbestaende.waldbestaende(t_basket,perimeter,flaeche_a,mischung,entwicklungsstufe,schlussgrad,bk_code,gemeinde,eigentuemer,astatus,mutation,nhd_anteil,hdom,hmax,gru_struktur,dg_os,dg_ms, dg_us, erstellungsjahr)
SELECT
  attributname oder gewünschter Wert,
  geom,
  flaeche_ha,
  code,
  gemeinde,
  e_name,
  'berechnet',
  '2020/09/17',
  ndh_anteil,
  hdom,
  hmax,
  gru_str,
  deck_grad,
  deck_gr_ms,
  deck_gr_us,
  2020

FROM dbu_aw_wa.import_waldbestaende_2020
;