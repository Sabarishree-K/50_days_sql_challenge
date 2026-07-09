use [50_days_sql_challenge];

--- 1. Analyze query performance before applying index using EXPLAIN ANALYZE ---

set statistics time on;

select e.emp_id,e.emp_name,e.dept_id, s.salary 
from cleaned_employees e 
inner join cleaned_salaries s
on e.emp_id = s.emp_id;

set statistics time off;

--- 2. Apply index on join columns and compare performance after indexing ---

create index idx_emp_dtls on cleaned_employees(emp_id);
create index idx_emp_sal on cleaned_salaries(emp_id);

set statistics time on;

select e.emp_id,e.emp_name,e.dept_id, s.salary 
from cleaned_employees e 
inner join cleaned_salaries s
on e.emp_id = s.emp_id;

set statistics time off;

--- 3. Analyze query using multiple conditions (emp_id, salary_date) and optimize using composite index ---

set statistics time on;

select emp_id,salary ,salary_date
from cleaned_salaries
where emp_id = 259 and salary_date = '2023-06-28'

set statistics time off;

create index idx_emp_sal1 on cleaned_salaries(emp_id,salary_date);

set statistics time on;

select emp_id,salary ,salary_date
from cleaned_salaries
where emp_id = 259 and salary_date = '2023-06-28'

set statistics time off;


--- 4. Compare query performance before and after applying index on emp_id ----

set statistics time on;

select * from cleaned_salaries 
where emp_id = 256;

set statistics time off;

create index  idx_emp_id  on cleaned_employees(emp_id);

set statistics time on;

select * from cleaned_salaries 
where emp_id = 256;

set statistics time off;
