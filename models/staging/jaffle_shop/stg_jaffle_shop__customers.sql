with
base_customers AS (
    select * from {{ source('jaffle_shop', 'src_customers') }}

),
transformed AS (
      select 
        id as customer_id,
        last_name as customer_last_name,
        first_name as customer_first_name,
        first_name + ' ' + last_name as customer_full_name
      from base_customers
)
select * from transformed