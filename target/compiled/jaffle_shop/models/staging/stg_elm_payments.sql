select orderid as order_id
       ,PaymentMethod
       ,status
       ,case when lower(status) = 'success' then amount else (-1) * (amount) end/ 100 as amount
       ,created
from raw.stripe.payment