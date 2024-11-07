Select
	o.order_id,
	o.customer_id,
	p.payment_amount

from {{ ref('stg_orders') }} o
inner join {{ ref('stg_payments') }} p
on o.order_id = p.order_id
and p.payment_status = 'success'