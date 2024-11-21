{% set order_status_values %}
    select distinct order_status from {{ ref('stg_orders') }}
{% endset %}

{%- if execute -%}
    {%- set order_statuses = run_query(order_status_values).columns[0].values() -%}   
    select customer_id
    {%- for order_status in order_statuses %}
         , sum(case when order_status = '{{ order_status }}' then 1 else 0 end) as {{ order_status }}_count
         
    {%- endfor %}
    from {{ ref('stg_orders') }}
    group by customer_id
{%- else -%}
    {%- set order_statuses = [] -%}   
    select {{ order_statuses }}
{%- endif -%}