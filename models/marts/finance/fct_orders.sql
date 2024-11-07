Select
	o.order_id,
	o.customer_id,
    o.order_date,
    o.order_status,
	p.payment_amount,
    p.payment_status

from {{ ref('stg_orders') }} o
inner join {{ ref('stg_payments') }} p
on o.order_id = p.order_id