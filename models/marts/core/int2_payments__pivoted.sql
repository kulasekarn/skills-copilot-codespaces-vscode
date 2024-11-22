-- Returns the list sorted alphabetically using a dbt_utils macro and passing the results to sql generation
{{
    config(
        materialized='table',
        required_tests=None
    )
}}


    {%- set pymt_methods = dbt_utils.get_column_values(
        table=ref('stg_payments'),
        where="payment_status = 'success'",
        column='payment_method',
        order_by='payment_method'
    ) -%}

with payments as (
    
    select * from {{ ref('stg_payments') }}

),
pivoted_output as (
    
    select order_id,
           
           {% for payment_method in pymt_methods -%}           
                sum(case when payment_method = '{{ payment_method }}' then payment_amount else 0 end) as {{ payment_method }}_amount 
                    {%- if not loop.last -%} , {% endif %}
           {% endfor %}           
    from payments
    where payment_status = 'success'
    group by order_id
)
select * 
from pivoted_output

