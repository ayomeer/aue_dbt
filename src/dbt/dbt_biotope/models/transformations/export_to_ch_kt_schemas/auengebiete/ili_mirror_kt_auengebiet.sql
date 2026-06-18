{{ config(materialized='table', enabled=false) }} 

SELECT 
  t_id::bigint,
  t_basket::bigint,
  t_ili_tid::uuid,
  kanton::character varying(255),
  objnummer::character varying(30),
  aname::character varying(80),
  obj_gisflaeche::numeric(12,3),
  -- au_typ::bigint,
  herkunft::character varying(250),
  kartierungsgrundlage::bigint,
  aufnahmedatum::date,
  mutationsdatum::date,
  -- mutationsgrund::text,
  -- mutationsgrund_de::text,
  -- mutationsgrund_fr::text,
  -- mutationsgrund_rm::text,
  -- mutationsgrund_it::text,
  -- mutationsgrund_en::text,
  bedeutung::bigint
FROM {{ ref('placeholder') }}

      Kanton : MANDATORY CHAdminCodes_V1.CHCantonCode;
      ObjNummer : MANDATORY TEXT*30;
      Name : TEXT*80;
      Obj_GISFlaeche : MANDATORY 1.000 .. 999999999.000 [Units.m2];
      AU_TYP : kt_Auengebiete_V1_1.Codelisten.AU_TYP_CatRef;
      Herkunft : MANDATORY TEXT*250;
      Kartierungsgrundlage : MANDATORY kt_Auengebiete_V1_1.Codelisten.Kartierungsgrundlage_CatRef;
      Aufnahmedatum : INTERLIS.XMLDate;
      Mutationsdatum : INTERLIS.XMLDate;
      Mutationsgrund : LocalisationCH_V1.MultilingualMText;
      Bedeutung : MANDATORY kt_Auengebiete_V1_1.Codelisten.Bedeutung_CatRef;