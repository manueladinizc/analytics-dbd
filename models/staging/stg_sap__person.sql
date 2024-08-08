with
    person as (
        select
            {{ int_col('businessentityid') }} as business_entity_id
            , concat('firstname', ' ', 'last_name') as full_name
            , coalesce(
                case
                    when persontype = 'EM' then 'Employee'
                    when persontype = 'IN' then 'Individual'
                    when persontype = 'SP' then 'Store Person'
                    when persontype = 'VC' then 'Vendor Contact'
                    when persontype = 'SC' then 'Sales Contact'
                    when persontype = 'GC' then 'General Contact'
                end, 'not provided') as person_type
        from {{ source('sap_adw', 'person') }}
    )
select *
from person