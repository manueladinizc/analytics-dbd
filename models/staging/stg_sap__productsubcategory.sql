with 
    productsubcategory as (
        select
            {{ int_col('productsubcategoryid') }} as product_subcategory_id
            , {{ int_col('productcategoryid') }} as product_category_id
            , {{ string_col('name') }} as product_subcategory_name
        from {{ source('sap_adw', 'productsubcategory') }}
    )
select *
from productsubcategory