select orderid as order_id
       ,PaymentMethod
       ,status
       ,amount / 100 as amount
       ,created
from raw.stripe.payment