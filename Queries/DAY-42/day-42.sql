use [50_days_sql_challenge];

--- 1. Create duplicate tables for cleaning process (clean_customers, clean_products, clean_orders, clean_order_details,clean_payments) ----

select * into clean_customers from raw_customers;
select * into clean_orders from raw_orders;
select * into clean_products from raw_products;
select * into clean_order_details from raw_order_details;
select * into clean_payments from raw_payments;

--- 2. Remove leading and trailing spaces using TRIM() in all tables ----

exec sp_help 'clean_customers'

update clean_customers
set customer_id = trim(customer_id),
    customer_name = trim(customer_name),
    city = trim(city);

exec sp_help 'clean_orders'

exec sp_help 'clean_products'

update clean_products
set product_name = trim(product_name),
    category = trim(category),
    price = trim(price);

exec sp_help 'clean_order_details'

exec sp_help 'clean_payments'

update clean_payments
set payment_amount = trim(payment_amount);

--- 3. Standardize text using UPPER() -----------

update clean_customers
set customer_name = upper(customer_name),
    city = upper(city);

select * from clean_customers;
   
update clean_products
set product_name = upper(product_name),
    category = upper(category);

select * from clean_products;

--- 4.  Replace NULL values with default values ------

select * from clean_customers
where city is null or 
      customer_name is null or 
      signup_date is null;

select * from clean_orders
where customer_id is null or 
      order_date is null;

select * from clean_order_details
where order_id is null or 
      product_id  is null or
      quantity is null;

select * from clean_products 
where product_name is null or 
      category is null or  
      price is null;

select * from clean_payments
where payment_amount is null or 
      payment_date is null;

--- 5.Remove duplicate records using ROW_NUMBER() ----

delete from clean_customers
where customer_id in (
        select customer_id from
        (select customer_id,
                ROW_NUMBER() over (partition by customer_id order by customer_id asc) as rn
         from clean_customers) t  
         where rn > 1 );

delete from clean_orders
where order_id in (
        select order_id from
        (select order_id,
                ROW_NUMBER() over (partition by order_id order by order_id) as rn
         from clean_orders) t  
         where rn > 1 );

delete from clean_order_details
where order_detail_id in (
        select order_detail_id from
        (select order_detail_id,
                ROW_NUMBER() over (partition by order_detail_id order by order_detail_id) as rn
         from clean_order_details) t  
         where rn > 1 );

delete from clean_products
where product_id in (
        select product_id from
        (select product_id,
                ROW_NUMBER() over (partition by product_id order by product_id) as rn
         from clean_products) t  
         where rn > 1 );

delete from clean_payments
where payment_id in (
        select payment_id from
        (select payment_id,
                ROW_NUMBER() over (partition by payment_id order by payment_id) as rn
         from clean_payments) t  
         where rn > 1 );