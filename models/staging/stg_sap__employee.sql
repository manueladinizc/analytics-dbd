with
    employee as (
        select
            {{ int_col('businessentityid') }} as business_entity_id
            , {{ string_col('jobtitle') }} as job_title
            , {{ string_col('gender') }} as gender
        from {{ source('sap_adw', 'employee') }}
    )
select *
from employee