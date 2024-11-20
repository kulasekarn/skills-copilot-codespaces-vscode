{{
    config(
        materialized='view'
    )
}}

-- import CTEs
WITH
base_payments AS (
    select * from {{ source('stripe', 'src_payments') }} 

),
-- Logical CTEs
customers AS (
      select 
        * 
      from {{ ref('stg_jaffle_shop__customers') }}
),

orders AS (
    select 
        * 
      from {{ ref('stg_jaffle_shop__orders') }}

),

customer_order_history AS (
    select 
        customers.customer_id ,
        customers.customer_full_name as name,
        customers.customer_last_name as surname,
        customers.customer_first_name as givenname,
        min(order_date) as first_order_date,
        min(case when orders.order_status NOT IN ('returned','return_pending') then order_date end) as first_non_returned_order_date,
        max(case when orders.order_status NOT IN ('returned','return_pending') then order_date end) as most_recent_non_returned_order_date,
        COALESCE(max(user_order_seq),0) as order_count,
        COALESCE(count(case when orders.order_status != 'returned' then 1 end),0) as non_returned_order_count,
        sum(case when orders.order_status NOT IN ('returned','return_pending') then ROUND(c.amount/100.0,2) else 0 end) as total_lifetime_value,
        sum(case when orders.order_status NOT IN ('returned','return_pending') then ROUND(c.amount/100.0,2) else 0 end)/NULLIF(count(case when orders.order_status NOT IN ('returned','return_pending') then 1 end),0) as avg_non_returned_order_value

    from orders

    join customers
    on orders.customer_id = customers.customer_id

    left outer join base_payments c
    on orders.order_id = c.orderid

    where orders.order_status NOT IN ('pending') and c.status != 'fail'

    group by customers.customer_id, customers.customer_full_name, customers.customer_last_name, customers.customer_first_name

),
-- Final CTE
final AS (
    select 
        orders.order_id,
        orders.customer_id,
        customer_order_history.surname,
        customer_order_history.givenname,
        customer_order_history.first_order_date,
        customer_order_history.order_count,
        customer_order_history.total_lifetime_value,
        round(amount/100.0,2) as order_value_dollars,
        orders.order_status as order_status,
        payments.status as payment_status
    from orders

    join customer_order_history
    on orders.customer_id = customer_order_history.customer_id

    left outer join base_payments as payments
    on orders.order_id = payments.orderid

    where payments.status != 'fail'
)

Select * from final