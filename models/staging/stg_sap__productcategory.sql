with
    productcategory as (
        select
            {{ int_col('productcategoryid') }} as product_category_id,
            {{ string_col('name') }} as product_category_name
        from {{ source('sap_adw', 'productcategory') }}
    )
select *
from productcategory
