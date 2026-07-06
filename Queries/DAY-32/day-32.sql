
use [50_days_sql_challenge];
--- 1. Create employee view to store reusable employee details ----

create view emp_details_view  as 
(
    select emp_id,emp_name,dept_id,city 
from cleaned_employees 
); 

select * from emp_details_view 
where city = 'Bangalore'

--- 2. Create salary view to store salary-related data ---

create view salary_details_view as 
(
select emp_id, salary, salary_date
from cleaned_salaries
);

select * from salary_details_view 
where salary_date = '2023-10-22'

--- 3. Create joined view combining employee and salary details ---

create view emp_sal_view as  
(
    select e.emp_id,e.emp_name,e.city,e.dept_id,s.salary,s.salary_date
    from cleaned_employees e  
    inner join cleaned_salaries s on e.emp_id = s.emp_id
);

--- 4. Use created view to filter employees with salary greater than 50000 ---

select * from emp_sal_view 
where salary > 50000
order by salary desc;

