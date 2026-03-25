{{ config(
     post_hook="{{ post_hook_export() }}"
)
}}

select * from {{ ref('stg_mgdm_data') }}