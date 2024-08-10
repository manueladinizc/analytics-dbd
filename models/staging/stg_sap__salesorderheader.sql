with
    salesorderheader as (
        select
            {{ int_col('salesorderid') }} as sales_order_id
            , {{ int_col('customerid') }} as customer_id
            , {{ int_col('salespersonid') }} as sales_person_id
            , {{ int_col('creditcardid') }} as credit_card_id
            , {{ int_col('territoryid') }} as territory_id
            , {{ int_col('shiptoaddressid') }} as ship_to_address_id
            , {{ int_col('status') }} as status
            , cast(subtotal as numeric) as sub_total
            , cast(taxamt as numeric) as tax_amount
            , cast(freight as numeric) as freight
            , cast(totaldue as numeric) as total_due
            , date(orderdate) as order_date
        from {{ source('sap_adw', 'salesorderheader') }}
    )
select *
from salesorderheader
