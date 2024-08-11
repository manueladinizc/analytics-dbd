with
    distinct_customer_id_salesorderheader as (
        select
            distinct customer_id
        from {{ ref('stg_sap__salesorderheader') }}
    )

    , customer as (
        select *
        from {{ ref('stg_sap__customer') }}
    )

    , person as (
        select *
        from {{ ref('stg_sap__person') }}
    )

    , final_transformation as (
        select
              row_number() over (order by dcs.customer_id) as sk_customer,
              c.customer_id,
              p.full_name,
              p.person_type,
              c.territory_id,
              c.store_id
          from distinct_customer_id_salesorderheader dcs
          left join customer c
              on dcs.customer_id = c.customer_id
          left join person p
              on c.person_id = p.business_entity_id
    )
select *
from final_transformation