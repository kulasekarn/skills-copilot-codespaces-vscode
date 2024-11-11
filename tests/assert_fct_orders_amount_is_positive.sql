with payments as (

    select order_id, payment_amount from {{ ref('fct_orders') }}

)
select order_id, sum(payment_amount) total_payment_amount
from payments
group by order_id
having sum(payment_amount) < 0