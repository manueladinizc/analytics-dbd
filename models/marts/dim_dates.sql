with
    dates_raw as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('1970-01-01' as date)",
        end_date="date_add(current_date(), interval 100 year)"
        )
    }}
)

    , days_info as (
        select 
            cast(date_day as date) as date_full,
            extract(day from date_day) as day_param,
            extract(month from date_day) as month_param,
            extract(year from date_day) as year_param,
            case
                when extract(month from date_day) = 1 then 'Janeiro'
                when extract(month from date_day) = 2 then 'Fevereiro'
                when extract(month from date_day) = 3 then 'Março'
                when extract(month from date_day) = 4 then 'Abril'
                when extract(month from date_day) = 5 then 'Maio'
                when extract(month from date_day) = 6 then 'Junho'
                when extract(month from date_day) = 7 then 'Julho'
                when extract(month from date_day) = 8 then 'Agosto'
                when extract(month from date_day) = 9 then 'Setembro'
                when extract(month from date_day) = 10 then 'Outubro'
                when extract(month from date_day) = 11 then 'Novembro'
                else 'Dezembro'
            end as month_name
        from dates_raw
    )

select
    row_number() over (order by date_full) as sk_date_full
    , date_full
    , day_param
    , month_param
    , month_name
    , year_param
from
    days_info