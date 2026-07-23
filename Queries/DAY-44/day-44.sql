use [50_days_sql_challenge];

--- 1.Find total number of customers----

select count(*) as total_customers
from clean_customers;

--- 2. Find total number of orders ----

select count(order_id) as total_orders
from clean_orders;

--- 3. Calculate total revenue from payments ---

select sum(payment_amount) as total_revenue
from clean_payments;

--- 4.Calculate average order value ----

select avg(payment_amount) as avg_order_value 
from clean_payments;

--- 5. Find total products sold ---

select sum(quantity) as total_products_sold
from clean_order_details

--- 6. Calculate orders per customer using GROUP BY --- 

select customer_id,count(order_id) as orders_per_customer
from clean_orders
group by customer_id
order by orders_per_customer desc;
