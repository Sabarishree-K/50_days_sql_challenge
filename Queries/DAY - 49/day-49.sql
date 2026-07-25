use [50_days_sql_challenge];

--- 1. Find Top 5 Customers by Revenue using CTE. -------------

with customer_revenue as  
(
    select c.customer_id, c.customer_name, c.city,sum(p.payment_amount) as total_revenue
    from clean_customers c  
    inner join clean_orders o on c.customer_id = o.customer_id
    inner join clean_payments p on o.order_id = p.order_id
    group by c.customer_id, c.customer_name, c.city
)

select top 5 * from customer_revenue
order by total_revenue desc;

--- 2. Find Top 5 Products by Quantity Sold using CTE. -------------

with total_quantity_sold as  
(
select p.product_id,p.product_name, count(od.quantity) as total_quantity
from clean_products p  
inner join clean_order_details od on od.product_id = p.product_id
group by p.product_id, p.product_name
)

select top 5 * from total_quantity_sold
order by total_quantity desc;

--- 3. Rank customers based on generated revenue using DENSE_RANK().  -------------

with customer_revenue as  
(
    select c.customer_id, c.customer_name, c.city,sum(p.payment_amount) as total_revenue
    from clean_customers c  
    inner join clean_orders o on c.customer_id = o.customer_id
    inner join clean_payments p on o.order_id = p.order_id
    group by c.customer_id, c.customer_name, c.city
)

select *,  dense_rank() over(order by total_revenue desc) as customer_rank
from customer_revenue
order by total_revenue desc;

--- 4. Rank products based on quantity sold using RANK().  -------------

with total_quantity_sold as  
(
    select p.product_id,p.product_name, count(od.quantity) as total_quantity
    from clean_products p  
    inner join clean_order_details od on od.product_id = p.product_id
    group by p.product_id, p.product_name
)

select  *, dense_rank() over(order by total_quantity desc) as product_rank
from total_quantity_sold
order by total_quantity desc;

--- 5. Find category-wise revenue using CTE.  -------------

with category_revenue as  
(
    select p.category, sum(p.price * od.quantity) as total_revenue
    from clean_products p  
    inner join clean_order_details od  on p.product_id = od.product_id
    group by p.category
)

select * from category_revenue
order by total_revenue desc;

--- 6. Categorize customers into High, Medium, and Low Revenue groups using CASE.  -------------

with customer_revenue as  
(
    select c.customer_id,sum(p.payment_amount) as total_revenue,
            case when sum(p.payment_amount) <= 20000 then 'low revenue'
                    when sum(p.payment_amount) <= 50000 then  'medium revenue'
                    else 'High revenue'
            end as category
    from clean_customers c  
    inner join clean_orders o on c.customer_id = o.customer_id
    inner join clean_payments p on o.order_id = p.order_id
    group by c.customer_id
)
select category, count(customer_id) as no_of_customers
from customer_revenue
group by category
order by no_of_customers desc;

--- 7. Create Stored Procedure for Customer Revenue Report.  -------------

create procedure customer_revenue_report
as  
BEGIN
    set nocount on;

    select c.customer_id, c.customer_name, c.city,sum(p.payment_amount) as total_revenue
    from clean_customers c  
    inner join clean_orders o on c.customer_id = o.customer_id
    inner join clean_payments p on o.order_id = p.order_id
    group by c.customer_id, c.customer_name, c.city
    order by total_revenue desc;

END;
GO

exec customer_revenue_report;
GO 

drop procedure customer_revenue_report