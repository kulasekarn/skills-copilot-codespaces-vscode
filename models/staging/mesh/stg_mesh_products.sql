with

source as (

    select * from  {{ source('jaffle_shop', 'raw_jaffle_shop_products') }}

),

renamed as (

    select

        ----------  ids
        sku as product_id,

        ---------- text
        name as product_name,
        type as product_type,
        description as product_description,


        ---------- numerics
        (price / 100.0) as product_price,

        ---------- booleans
        --coalesce(type = 'jaffle', false) as is_food_item,
		case when type = 'jaffle' then 'true' else 'false' end as is_food_item,

        --coalesce(type = 'beverage', false) as is_drink_item
		case when type = 'beverage' then 'true' else 'false' end as is_drink_item

    from source

)

select * from renamed