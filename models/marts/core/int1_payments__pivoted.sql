-- Returns the list sorted alphabetically using our own built in query and passing the results to sql generation
{{
    config(
        materialized='table'
    )
}}

    {%- set select_query -%}
        select distinct payment_method 
        from {{ ref('stg_payments') }}
        where payment_status = 'success'
        order by payment_method
    {%- endset -%}

    {%- if execute -%}
        {%- set pymt_methods = run_query(select_query).columns[0].values() -%}   
        {{ log('List of payment methods: ' ~ pymt_methods, info=True) }} 
    {%- else -%}
        {%- set pymt_methods = [] -%}   
        {{ log('List of payment methods: ' ~ pymt_methods, info=True) }} 
    {%- endif -%}

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

