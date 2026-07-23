use [50_days_sql_challenge];

--- 1. Fix incorrect data types across all cleaned tables ----
--- 2. Modify columns using appropriate data types (INT, VARCHAR, DECIMAL, DATE)
--- 3. Add Primary Key and Foreign Key constraints  ----

------------- clean_customers table -------------------

select * from clean_customers;

alter table clean_customers
alter column customer_id int NOT NULL;

alter table clean_orders
add CONSTRAINT pk_clean_orders PRIMARY KEY(order_id);

exec sp_help 'clean_customers'

------------- clean_orders table ----------------------

select * from clean_orders;

alter table clean_orders
alter column customer_id int NOT NULL;
            
alter table clean_orders
add constraint fk_customer
foreign key (customer_id)
REFERENCES clean_customers(customer_id);

exec sp_help 'clean_orders';

------------- clean_products table --------------------

select * from clean_products;

alter table clean_products
alter column product_name varchar(100);

alter table clean_products
alter column category varchar(100);

alter table clean_products
alter column price decimal (10,2);

alter table clean_products
add constraint pk_clean_products primary key(product_id);

exec sp_help 'clean_products';

------------- clean_order_details  table -------------------

select * from clean_order_details;

alter table clean_order_details
alter column product_id int NOT NULL;

alter table clean_order_details
add constraint pk_clean_order_details
PRIMARY KEY (order_detail_id);

alter table clean_order_details
add constraint fk_order
foreign key (order_id)
REFERENCES clean_orders(order_id);

alter table clean_order_details
add constraint fk_product
foreign key (product_id)
REFERENCES clean_products(product_id);

exec sp_help 'clean_order_details'

------------- clean_payments table --------------------------

select * from clean_payments;

alter table clean_payments
alter column payment_amount decimal(10,2);

alter table clean_payments
add constraint pk_clean_payments
primary key (payment_id);

alter table clean_payments
add constraint fk_payment
FOREIGN KEY (order_id)
REFERENCES clean_orders(order_id);

