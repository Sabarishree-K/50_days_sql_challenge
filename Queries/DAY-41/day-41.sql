use [50_days_sql_challenge]; 

--- 1. Create all tables based on the given ER Diagram ----

create table raw_customers
(   customer_id varchar(50),
    customer_name varchar(100),
    city varchar (50),
    signup_date varchar(50));

create table raw_orders
(   order_id varchar(50),
    customer_id varchar (50),
    order_date varchar(50));

create table raw_products
(   product_id varchar (50),
    product_name varchar(100),
    category varchar(100),
    price varchar(50));

create table raw_order_details
(   order_detail_id varchar(50),
    order_id varchar(50),
    product_id varchar(50),
    quantity varchar(50));

create table raw_payments
(   payment_id varchar(50),
    order_id varchar (50),
    payment_amount varchar(50),
    payment_date varchar(50));

--- 2. Load dataset into MySQL tables using import/load methods ---

select * from raw_customers;
select * from raw_orders;
select * from raw_products;
select * from raw_order_details;
select  * from raw_payments;