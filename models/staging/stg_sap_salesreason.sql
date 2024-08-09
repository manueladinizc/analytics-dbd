with
    salesreason as (
        select
            {{ int_col('salesreasonid') }} as sales_reason_id
            , {{ string_col('name') }} as sales_reason_description
            , coalesce({{ string_col('reasontype') }}, 'not provided') as reason_type
        from {{ source('sap_adw', 'salesreason') }}
    )
select *
from salesreason