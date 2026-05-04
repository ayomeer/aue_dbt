




    
    
    

    

    with 

    
    

    a_base as (
        select 
            gid, art_wiss, art_deutsch, spezart, substrat, radius, ext_label, ext_herkunft, copyright, funddatum, finder, kantonsintern, verwaltungsintern, bemerkungen, fotos, genauigkeit_ausreichend, biotopstatus, id_gl_aus_import, last_user, oid_uuid, id_from_cat_arten, e, n, dat_hinzugefuegt_am, neobiot, qualitaetskontrolle, taxonidch, ext_hoehe, gemeinde_kt_glarus, loeschmarkierung, geometrie, 
            md5(cast(coalesce(cast(geometrie as TEXT), '_dbt_audit_helper_surrogate_key_null_') || '-' || coalesce(cast(funddatum as TEXT), '_dbt_audit_helper_surrogate_key_null_') || '-' || coalesce(cast(art_wiss as TEXT), '_dbt_audit_helper_surrogate_key_null_') as TEXT)) as dbt_audit_surrogate_key
        from (
  select
    *
  from "test_db"."prod_gl_arten"."bkp_artvorkommen"
) a_base_subq
        
    

    ),

    b_base as (
        select 
            gid, art_wiss, art_deutsch, spezart, substrat, radius, ext_label, ext_herkunft, copyright, funddatum, finder, kantonsintern, verwaltungsintern, bemerkungen, fotos, genauigkeit_ausreichend, biotopstatus, id_gl_aus_import, last_user, oid_uuid, id_from_cat_arten, e, n, dat_hinzugefuegt_am, neobiot, qualitaetskontrolle, taxonidch, ext_hoehe, gemeinde_kt_glarus, loeschmarkierung, geometrie, 
            md5(cast(coalesce(cast(geometrie as TEXT), '_dbt_audit_helper_surrogate_key_null_') || '-' || coalesce(cast(funddatum as TEXT), '_dbt_audit_helper_surrogate_key_null_') || '-' || coalesce(cast(art_wiss as TEXT), '_dbt_audit_helper_surrogate_key_null_') as TEXT)) as dbt_audit_surrogate_key
        from (
  select
    *
  from "test_db"."prod_gl_arten"."artvorkommen_gl_pt"
) b_base_subq
        
    

    ),

    a as (
        select 
            *, 
            row_number() over (partition by dbt_audit_surrogate_key order by dbt_audit_surrogate_key) as dbt_audit_pk_row_num
        from a_base
    ),

    b as (
        select 
            *, 
            row_number() over (partition by dbt_audit_surrogate_key order by dbt_audit_surrogate_key) as dbt_audit_pk_row_num
        from b_base
    ),

    a_intersect_b as (

        select * from a
        

    intersect


        select * from b

    ),

    a_except_b as (

        select * from a
        

    except


        select * from b

    ),

    b_except_a as (

        select * from b
        

    except


        select * from a

    )

    
    ,

    all_records as (

        select
            *,
            true as dbt_audit_in_a,
            true as dbt_audit_in_b
        from a_intersect_b

        union all

        select
            *,
            true as dbt_audit_in_a,
            false as dbt_audit_in_b
        from a_except_b

        union all

        select
            *,
            false as dbt_audit_in_a,
            true as dbt_audit_in_b
        from b_except_a

    ),

    classified as (
        select 
            *,
            case 
        when max(dbt_audit_pk_row_num) over (partition by dbt_audit_surrogate_key) > 1 then 'nonunique_pk'
        when dbt_audit_in_a and dbt_audit_in_b then 'identical'
        when bool_or(dbt_audit_in_a) over (partition by dbt_audit_surrogate_key, dbt_audit_pk_row_num) 
            and bool_or(dbt_audit_in_b) over (partition by dbt_audit_surrogate_key, dbt_audit_pk_row_num)
            then 'modified'
        when dbt_audit_in_a then 'removed'
        when dbt_audit_in_b then 'added'
    end
 as dbt_audit_row_status
        from all_records
    ),

    final as (
        select 
            *,
            
    dense_rank() over (partition by dbt_audit_row_status order by dbt_audit_surrogate_key, dbt_audit_pk_row_num)
    + dense_rank() over (partition by dbt_audit_row_status order by dbt_audit_surrogate_key desc, dbt_audit_pk_row_num desc)
    - 1

 as dbt_audit_num_rows_in_status,
            -- using dense_rank so that modified rows (which have a full row for both the left and right side) both get picked up in the sample. 
            -- For every other type this is equivalent to a row_number()
            dense_rank() over (partition by dbt_audit_row_status order by dbt_audit_surrogate_key, dbt_audit_pk_row_num) as dbt_audit_sample_number
        from classified
    )

    select * from final
    
        where dbt_audit_sample_number <= 20
    
    order by dbt_audit_row_status, dbt_audit_sample_number

