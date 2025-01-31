with orders as (
    select * from {{ ref('int_mesh_orders') }}
),

final as (
    select 
        order_id,
        location_id,
        customer_id,
        order_total,
        tax_paid,
        ordered_at,
        customer_name,
        location_name,
        tax_rate,
        location_opened_at,
        datepart(month, ordered_at) as ordered_month,
        datepart(day, ordered_at) as ordered_day, 
        datepart(year, ordered_at) as ordered_year
    from orders
)

select * 
from final