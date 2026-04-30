
    -- "case" benutzen anstelle von "update" im Skript "2_wis_artvorkommen_leere_Zellen_ersetzen" und dann in Skript "1_Aktualisieren_wis_artvorkommen" integrieren.
       
	case
          when c.schutz_ch is null then 'nicht geschuetzt'
          else c.schutz_ch
       end as schutz_status_schweiz,

       case
          when c.rl_status is null and f.art_deutsch = 'Tamarisken-Wassersackmoos' then 'NT'
          else c.rl_status 
       end as rote_liste_status,
 
       case
          when f.radius is null then 99999
          else f.radius
       end as radius,