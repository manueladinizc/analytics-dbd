with
    salesorderheader as (
        select
            {{ int_col('salesorderid') }} as sales_order_id
            , {{ int_col('customerid') }} as customer_id
            , {{ int_col('salespersonid') }} as sales_person_id
            , coalesce({{ int_col('creditcardid') }}, ) as credit_card_id
            , {{ int_col('territoryid') }} as territory_id
            , {{ int_col('shiptoaddressid') }} as ship_to_address_id
            , {{ int_col('status') }} as status
            , cast('subtotal', 'numeric') as sub_total
            , cast('taxamt', 'numeric') as tax_amount
            , cast('freight', 'numeric') as freight
            , cast('totaldue', 'numeric') as total_due
            , cast(orderdate as date) as order_date
        from {{ source('sap_adw', 'salesorderheader') }}
    )
select *
from salesorderheader
