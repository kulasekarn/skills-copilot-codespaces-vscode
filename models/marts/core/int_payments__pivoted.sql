{{
    config(
        materialized='table'
    )
}}
{%- set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}
with payments as (
    
    select * from {{ ref('stg_payments') }}

),
pymnt_methods as (
    
    select distinct payment_method 
    from payments
    where payment_status = 'success'

),
pivoted_output as (
    
    select order_id,
           
           {% for payment_method in payment_methods -%}           
                sum(case when payment_method = '{{ payment_method }}' then payment_amount else 0 end) as {{ payment_method }}_amount 
                    {%- if not loop.last -%} , {% endif %}
           {% endfor %}           
    from payments
    where payment_status = 'success'
    group by order_id
)
select * 
from pivoted_output

