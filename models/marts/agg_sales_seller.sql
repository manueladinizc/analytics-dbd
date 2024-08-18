with
    sales_order_detail as (
        select
            sales_order_id
            , order_qty
            , unit_price
            , unit_price_discount
            , (unit_price * order_qty) as total_price
            , (unit_price * order_qty * (1 - unit_price_discount)) as total_price_with_discounted
        from {{ ref('stg_sap__salesorderdetail') }}
    )

    , sales_order_header as (
        select
            sales_order_id
            , sales_person_id
            , transaction_amount
        from {{ ref('stg_sap__salesorderheader') }}
    )

    , employee as (
        select
            business_entity_id
            , job_title
            , gender
        from {{ ref('stg_sap__employee') }}
    )

    , person as (
        select
            business_entity_id
            , full_name
        from {{ ref('stg_sap__person') }}
    )

    , join_sales as (
        select
            sod.sales_order_id
            , soh.sales_person_id
            , soh.transaction_amount
            , sod.total_price
            , sod.total_price_with_discounted
            , sod.order_qty
            , p.full_name
            , e.job_title
            , e.gender
        from sales_order_detail sod
        left join sales_order_header soh
            on sod.sales_order_id = soh.sales_order_id
        left join person p
            on soh.sales_person_id = p.business_entity_id
        left join employee e
            on soh.sales_person_id = e.business_entity_id
            where soh.sales_person_id is not null
    )

    , agg_sales_seller as (
        select
            sales_person_id as sk_seller
            , full_name
            , job_title
            , gender
            , sum(transaction_amount) as total_transaction_amount
            , sum(total_price) as total_price
            , sum(total_price_with_discounted) as total_price_with_discounted
            , sum(order_qty) as total_order_qty
        from join_sales
        group by
            sales_person_id
            , full_name
            , job_title
            , gender
    )
select *
from agg_sales_seller