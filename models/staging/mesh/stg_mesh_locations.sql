with

source as (

    select * from {{ source('jaffle_shop', 'raw_jaffle_shop_stores') }}
),

renamed as (

    select

        ----------  ids
        id as location_id,

        ---------- text
        name as location_name,

        ---------- numerics
        tax_rate,

        ---------- timestamps
        opened_at as location_opened_at

    from source

)

select * from renamed