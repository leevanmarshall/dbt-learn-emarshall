

      create or replace transient table analytics.analytics.customers  as
      (with customers as (
    select * from analytics.analytics.stg_elm_customers
),
orders as (
    select * from analytics.analytics.stg_elm_orders
),
payments as (
    select * from analytics.analytics.stg_elm_payments
),customer_payments as
(
    select order_id, sum(amount) as amount
    from payments
    group by order_id
)
,customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(amount) as totalPayment
    from orders od
    left join customer_payments using (order_id)
    group by 1
),
final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_orders.totalPayment, 0) as totalPayment
    from customers
    left join customer_orders using (customer_id)
)
select * from final
      );
    