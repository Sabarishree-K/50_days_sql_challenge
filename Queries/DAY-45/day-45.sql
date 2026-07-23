use [50_days_sql_challenge];

--- 1. Find top customers by number of orders ---

select c.customer_id,c.customer_name,c.city, count(o.order_id) as total_orders 
from clean_customers c
inner join clean_orders o on c.customer_id = o.customer_id
group by c.customer_id,c.customer_name,c.city
order by total_orders desc;

--- 2. Find top customers by generated revenue --(customers generating highest revenue)--

select top 15 o.customer_id,c.customer_name,c.city,sum(p.payment_amount) as total_revenue
from clean_orders o
inner join clean_payments p on o.order_id = p.order_id
inner join clean_customers c on c.customer_id = o.customer_id
group by o.customer_id,c.customer_name,c.city
order by total_revenue desc;

--- 3. Find customers with no orders  -----

select c.customer_id,c.customer_name,c.city, count(o.order_id) as total_orders 
from clean_customers c
left join clean_orders o on c.customer_id = o.customer_id
group by c.customer_id,c.customer_name,c.city
having count(o.order_id) < 1

select c.customer_id,c.customer_name,c.city,o.order_id
from clean_customers c
left join clean_orders o on c.customer_id = o.customer_id
where order_id is null;

--- 4. Analyze new customer signup trend month-wise -----

select month(signup_date) as month_no, 
       datename(month,signup_date) as month_name,
       count(customer_id) as new_customers
from clean_customers
group by month(signup_date),datename(month,signup_date)
order by month_no

--- 5. Find repeat customers with multiple orders -----

select c.customer_id,c.customer_name,c.city, count(o.order_id) as total_orders 
from clean_customers c
inner join clean_orders o on c.customer_id = o.customer_id
group by c.customer_id,c.customer_name,c.city
having count(o.order_id) > 1
order by total_orders desc;

--- 6. Calculate customer lifetime value ---(Find total spending of each customer)---

select o.customer_id,c.customer_name,c.city,sum(p.payment_amount) as lifetime_value
from clean_orders o
inner join clean_payments p on o.order_id = p.order_id
inner join clean_customers c on c.customer_id = o.customer_id
group by o.customer_id,c.customer_name,c.city
order by lifetime_value desc;

--- 7. Calculate average spend per customer ----

select o.customer_id,c.customer_name,c.city,avg(p.payment_amount) as avg_amount_spent
from clean_orders o
inner join clean_payments p on o.order_id = p.order_id
inner join clean_customers c on c.customer_id = o.customer_id
group by o.customer_id,c.customer_name,c.city
order by avg_amount_spent desc;

--- 8. Find total customers per city -----

select city,count(city) as total_customers
from clean_customers
group by city
order by total_customers desc;