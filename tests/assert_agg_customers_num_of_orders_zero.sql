with zero_orders as (

    select first_order_date, most_recent_order_date, number_of_orders 
    from {{ ref('agg_customers') }}
    where number_of_orders = 0

)
select *
from zero_orders
where first_order_date is not null and most_recent_order_date is not null