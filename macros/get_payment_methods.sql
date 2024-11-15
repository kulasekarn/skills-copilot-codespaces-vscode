{% macro get_payment_methods() %}

    {%- set select_query -%}
        select distinct payment_method 
        from {{ ref('stg_payments') }}
        where payment_status = 'success'
    {%- endset -%}

    {%- if execute -%}
        {%- set pymt_methods = run_query(select_query).columns[0].values() -%}   
        {{ log('List of payment methods: ' ~ pymt_methods, info=True) }} 
    {%- else -%}
        {%- set pymt_methods = [] -%}   
        {{ log('List of payment methods: ' ~ pymt_methods, info=True) }} 
    {%- endif -%}
    
        {{ pymt_methods }}
    
{%- endmacro -%}