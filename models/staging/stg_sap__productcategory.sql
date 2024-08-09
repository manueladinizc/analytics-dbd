with
    productcategory as (
        select
            {{ int_col('productcategoryid') }} as product_category_id,
            {{ string_col('name') }} as product_category_name
        from {{ source('sap_adw', 'productcategory') }}
    ),

    productsubcategory as (
        select
            {{ int_col('productsubcategoryid') }} as product_subcategory_id,
            {{ int_col('productcategoryid') }} as product_category_id,
            {{ string_col('name') }} as product_subcategory_name
        from {{ source('sap_adw', 'productsubcategory') }}
    ),

    join_category_subcategory as (
        select
            ps.product_subcategory_id,
            ps.product_subcategory_name,
            pc.product_category_id,
            pc.product_category_name
        from productsubcategory ps
        join productcategory pc
            on ps.product_category_id = pc.product_category_id
    )

select *
from join_category_subcategory
