with
    salesorderdetail as (
        select
            sales_order_id
            , product_id
            , order_qty as order_product_qty
            , unit_price
            , unit_price_discount
            , coalesce(unit_price * order_qty, 0) as total_price
            , coalesce(unit_price * order_qty * (1 - unit_price_discount), 0) as total_price_with_discounted
        from {{ ref('stg_sap__salesorderdetail') }}
    )

    , salesorderheader as (
        select
            sales_order_id
            , customer_id
            , sales_person_id
            , credit_card_id
            , territory_id
            , ship_to_address_id
            , order_status
            , tax_amount
            , freight
            , total_due as transaction_amount
            , order_date
        from {{ ref('stg_sap__salesorderheader') }}
    )

    , final_transformation as (
        select
            row_number() over (order by soh.customer_id) as fk_customer
            , row_number() over (order by soh.ship_to_address_id) as fk_locales
            , row_number() over (order by soh.credit_card_id) as fk_person_credit_card
            , row_number() over (order by soh.sales_order_id) as sk_sales_reason
            , row_number() over (order by soh.order_date) as fk_date_full
            , row_number() over (order by sod.product_id) as fk_product

            , sod.sales_order_id
            , sod.order_product_qty
            , sod.unit_price
            , sod.unit_price_discount
            , sod.total_price
            , sod.total_price_with_discounted

            , soh.order_status
            , soh.tax_amount
            , soh.freight
            , soh.transaction_amount
            , soh.order_date
        from salesorderdetail sod
        left join salesorderheader soh
            on sod.sales_order_id = soh.sales_order_id
    )
select *
from final_transformation