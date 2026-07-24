use [50_days_sql_challenge];

--- 1.Find number of orders placed daily. ----

select order_date,count(order_id) as no_of_orders
from clean_orders
group by order_date
order by order_date;

--- 2.Find monthly order trend.-----

select month(order_date) as month_no,
    datename(month,order_date) as month_name,
    count(order_id) as total_orders
from clean_orders
group by month(order_date),datename(month,order_date) 
order by month_no

--- 3.Find the highest value order.  -------

select top 1 order_id,payment_amount 
from clean_payments
order by payment_amount desc;

--- 4.Find the lowest value order. -------

select top 1 order_id,payment_amount 
from clean_payments
order by payment_amount;

--- 5.Find average quantity per order.-------

select avg(total_quantity) as avg_qty_per_order
from 
    ( select od.order_id,sum(od.quantity) as total_quantity
      from clean_order_details od  
      group by order_id  ) t

--- 6.Categorize orders by quantity size (Small <=2 / Medium <=5 / else Large Orders). -------

with order_category as(
    select  case when quantity <= 2 then 'small order'
             when quantity <= 5 then 'medium order'
             else 'large order'
        end as category 
    from clean_order_details)
       
select category, count(*) as total_orders 
from order_category 
group by category;

--- 7.Find the day with the highest number of orders.  -------

select top 3 order_date,count(order_id) as no_of_orders
from clean_orders
group by order_date
order by  no_of_orders desc;
