with
    customer as (
        select 
            {{ string_col('customerid') }} as customer_id
            , {{ string_col('personid') }} as person_id
            , {{ string_col('territoryid') }} as territory_id
        from {{ source('sap_adw', 'customer') }}
    )
select *
from customer