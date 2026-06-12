

use [50_days_sql_challenge];

--- 1. Show only employees who have valid department  -----

select e.emp_id, e.emp_name, d.dept_name 
from cleaned_employees e
inner join cleaned_departments d 
on e.dept_id = d.dept_id;

--- 2. Show all employees (even without department)  -------

select e.emp_id, e.emp_name, e.dept_id, d.dept_name 
from cleaned_employees e
left join cleaned_departments d 
on e.dept_id = d.dept_id;

--- 3. Find employees without department  ------

select * from cleaned_employees 
where dept_id > 10;

------  using joins --------------
select e.emp_id, e.emp_name, e.dept_id, d.dept_name 
from cleaned_employees e
left join cleaned_departments d 
on e.dept_id = d.dept_id
where  d.dept_name is null;

---- 4. Find who earns how much --------

select e.emp_id, e.emp_name,d.dept_name, s.salary 
from cleaned_employees e  
INNER JOIN cleaned_departments d  
on e.dept_id = d.dept_id
INNER JOIN cleaned_salaries s  
on e.emp_id = s.emp_id
where s.salary is not null;

---- 5. List employees without salary -----

select e.emp_id, e.emp_name,d.dept_name, s.salary 
from cleaned_employees e  
INNER JOIN cleaned_departments d  
on e.dept_id = d.dept_id
LEFT JOIN cleaned_salaries s  
on e.emp_id = s.emp_id
where s.salary is null;

