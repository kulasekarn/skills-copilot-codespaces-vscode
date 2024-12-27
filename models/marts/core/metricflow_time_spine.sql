{{
    config(
        materialized = 'table',
    )
}}

with days as (

    {{
        dbt.date_spine(
            'day',
            "cast('01/01/2021' as date)",
            "cast('01/01/2025' as date)"
        )
    }}

),

final as (
    select cast(date_day as date) as date_day
    from days
)

select * from final
where date_day > dateadd(year, -4, current_timestamp) 
and date_day < dateadd(day, 30, current_timestamp)