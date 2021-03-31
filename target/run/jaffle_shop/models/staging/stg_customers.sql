

      create or replace transient table analytics.analytics.stg_customers  as
      (select
    id as customer_id,
    first_name,
    last_name
from raw.jaffle_shop.customers
      );
    