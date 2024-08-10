with
    salesperson as (
        select
            {{ int_col('businessentityid') }} as business_entity_id
            , {{ int_col('territoryid')}} as territory_id
            , cast(salesytd as numeric) as sales_ytd
            , cast(saleslastyear as numeric) as sales_last_year
        from {{ source('sap_adw', 'salesperson')}}
    )
select *
from salesperson