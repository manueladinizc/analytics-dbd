with
    countryregion as (
        select 
            {{ string_col('countryregioncode') }} as country_region_code
            , {{ string_col('name') }} as country_name
        from {{ source('sap_adw', 'countryregion') }}
    )
select *
from countryregion