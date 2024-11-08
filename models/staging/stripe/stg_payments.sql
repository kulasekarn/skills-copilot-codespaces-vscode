Select 

      ID AS payment_id
    , ORDERID AS order_id
    , PAYMENTMETHOD AS payment_method
    , STATUS AS payment_status
    , AMOUNT/100 AS payment_amount

from {{ source('jaffle_shop', 'src_payments') }}