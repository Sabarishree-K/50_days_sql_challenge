use [50_days_sql_challenge];

--- use row number to find duplicate records---
--- delete duplictaes from employees table---
begin transaction;

with cte as (
            select emp_id,emp_name,city,
            row_number() over (partition by emp_id order by emp_id) as row_num
            from cleaned_employees
            )
           delete from cte where row_num > 1;

rollback;
select @@trancount;
         
select * from cleaned_employees;

--- delete duplictaes from salaries table---

begin transaction; 

select salary_id,emp_id,salary,count(*) as count 
from cleaned_salaries
group by salary_id,emp_id,salary
having count(*) >1;

with cte as ( 
                select *,
                row_number() over (partition by salary_id order by salary_id) as row_num
                from cleaned_salaries
            )
            delete from cte where row_num > 1;

select * from cleaned_salaries;

--- delete duplictaes from performance table---

select *,count(*) as count 
from cleaned_performance 
group by emp_id,rating_2022,rating_2023,rating_2024
having count(*) >1;

with cte as (
                select *, 
                row_number () over (partition by emp_id order by emp_id) as row_num 
                from cleaned_performance 
            )   
            delete from cte where row_num > 1;

select * from cleaned_performance;

--- Identify text inconsistency ----

select distinct city from cleaned_employees ;

--- trim spaces and capitalize first letter in each city----

update cleaned_employees 
set city = concat( 
                   upper(left(trim(city),1)),
                   lower(substring(trim(city),2))
                );

--- correct the mispelled city names ----

update cleaned_employees 
set city = 'Hyderabad'
where city = 'Hydbd'

update cleaned_employees 
set city = case 
when city in ('dlhi', 'new delhi') then  'Delhi' 
when city in ('bangalore') then  'Bengaluru'
else city
end;