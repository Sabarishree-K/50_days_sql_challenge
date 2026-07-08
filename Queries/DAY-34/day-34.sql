use [50_days_sql_challenge];

--- 1. Create index on emp_id to speed up employee search ----

create index idx_emp_id 
on cleaned_employees(emp_id);

select * from cleaned_employees 
where emp_id = 242;

--- 2. Create index on dept_id for faster department-based filtering ---

create index idx_dept_id 
on cleaned_employees(dept_id);

select * from cleaned_employees 
where dept_id = 6;

--- 3. Create composite index on (emp_id, salary_date) for optimized multi-column queries ---


create index idx_emp_salary_date
on cleaned_salaries(emp_id,salary_date);

select * from cleaned_salaries
where emp_id = 43 and salary_date = '2023-01-03'