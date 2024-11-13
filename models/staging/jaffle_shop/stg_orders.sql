    select
        ID as order_id,
        USER_ID as customer_id,
        ORDER_DATE as order_date,
        STATUS as order_status

    from {{ source('jaffle_shop', 'src_orders') }}
    {{ limit_data_in_dev('order_date', 10000)}}