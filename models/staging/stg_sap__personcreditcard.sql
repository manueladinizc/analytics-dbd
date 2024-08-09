with 
    creditcard as (
        select 
          {{ int_col('creditcardid') }} as credit_card_id
          , {{ string_col('cardtype') }} as card_type
        from {{ source('sap_adw', 'creditcard') }}
    ),

    personcreditcard as (
        select 
            {{ int_col('creditcardid') }} as credit_card_id
            , {{ string_col('businessentityid') }} as business_entity_id
    from {{ source('sap_adw', 'personcreditcard') }}
    ),

    join_creditcard_personcreditcard as (
        select 
            cc.credit_card_id
            , cc.card_type
            , pcc.business_entity_id
        from creditcard cc
        join personcreditcard pcc
            on cc.credit_card_id = pcc.credit_card_id
    )
select *
from join_creditcard_personcreditcard
