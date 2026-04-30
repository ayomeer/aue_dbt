-- *************************************************************
-- Skript für die Vereinheitlichung der Rote Liste Bezeichnungen
-- in prod_gl_biotope.cat_arten
-- Stand 27.5.2020 PZ / BK
-- *************************************************************

-- alter table prod_gl_biotope.cat_arten add column ori_rl_status character varying;
-- update prod_gl_biotope.cat_arten SET ori_rl_status=rl_status;

UPDATE prod_gl_biotope.cat_arten
   SET rl_status='EX'
WHERE ori_rl_status = '0(e)' OR ori_rl_status = '0' OR Left(ori_rl_status,1) = 'R' OR Left(ori_rl_status,2) = 'EX' ;

UPDATE prod_gl_biotope.cat_arten
   SET rl_status='CR'
WHERE ori_rl_status = '1(e)' OR ori_rl_status = '1';

 UPDATE prod_gl_biotope.cat_arten
   SET rl_status='EN'
 WHERE ori_rl_status = '2(e)' OR ori_rl_status = '2' OR left(ori_rl_status,2) ='EN';

  UPDATE prod_gl_biotope.cat_arten
   SET rl_status='VU'
 WHERE ori_rl_status = '3(e)' OR ori_rl_status = '3' OR left(ori_rl_status,2) ='VU';

  UPDATE prod_gl_biotope.cat_arten
   SET rl_status='NT'
 WHERE ori_rl_status = '4(e)' OR ori_rl_status = '4' OR left(ori_rl_status,2) ='NT';;

   UPDATE prod_gl_biotope.cat_arten
   SET rl_status='CR'
 WHERE left(ori_rl_status,2) = 'CR' OR ori_rl_status = '(CR)';

    UPDATE prod_gl_biotope.cat_arten
   SET rl_status='DD'
 WHERE left(trim(ori_rl_status),2) = 'DD' OR ori_rl_status = 'NE' OR ori_rl_status = 'n(e)' OR left(trim(ori_rl_status),2) = 'NA';

   UPDATE prod_gl_biotope.cat_arten
   SET rl_status='LC'
 WHERE left(ori_rl_status,2) = 'LC';

-- 2. formale Bereinigung Daten in rl-status

 UPDATE prod_gl_biotope.cat_arten
   SET rl_status=trim(rl_status);

 UPDATE prod_gl_biotope.cat_arten
   SET rl_status='kA'
   where rl_status='' or rl_status=' ' or rl_status is null;
 


