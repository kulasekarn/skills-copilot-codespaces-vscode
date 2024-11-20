with
base_orders AS (
    Select * from {{ source('jaffle_shop', 'src_orders') }}

),
transformed AS (
      select 
        id as order_id,
        user_id as customer_id,
        order_date,
        status as order_status,
        row_number() over (partition by user_id order by order_date, id) as user_order_seq
      from base_orders
)
select * from transformed
