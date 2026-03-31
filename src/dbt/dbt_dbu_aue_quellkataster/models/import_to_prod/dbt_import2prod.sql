SELECT 
  fid,
  schluessel,
  objektname,
  access_messdaten_schuettungsmenge as schuettungsmenge
FROM {{source('quellobjekte', 'src_access_objektdaten')}}


