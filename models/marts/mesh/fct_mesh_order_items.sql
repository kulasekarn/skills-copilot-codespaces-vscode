with orders as (
    select * from {{ ref('int_mesh_orders') }}
),

order_items as (
    select * from {{ ref('stg_mesh_order_items') }}
),

joined as (
    select 
        order_items.order_item_id, order_items.order_id, order_items.product_id,
        orders.location_id, orders.customer_id, orders.order_total, orders.tax_paid, orders.ordered_at,
		orders.customer_name, orders.location_name, orders.tax_rate, orders.location_opened_at
        
    from orders 
        inner join order_items 
            on orders.order_id = order_items.order_id
)

select * from joined