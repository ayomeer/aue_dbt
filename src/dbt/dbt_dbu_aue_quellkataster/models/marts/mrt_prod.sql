with mgdm_data as (
    select *
    from {{ ref('stg_mgdm_data')}}
),

pub_data as (
    select *
    from {{ ref('stg_pub_data') }}
)

select 
    mgdm.*,
    schuettungsmenge,
    behoerde,
    beschluss,
    datenherr,
    plangrundlage
from mgdm_data as mgdm
inner join pub_data as pub
    on pub.fid = mgdm.fid


