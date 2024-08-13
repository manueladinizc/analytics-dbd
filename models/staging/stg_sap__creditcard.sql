with
    creditcard as (
        select
          {{ int_col('creditcardid') }} as credit_card_id
          , {{ string_col('cardtype') }} as card_type
        from {{ source('sap_adw', 'creditcard') }}
    )
select *
from creditcard