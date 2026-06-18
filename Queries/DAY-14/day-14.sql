
use [50_days_sql_challenge];

--- 1. List employees earning more than the department average salary ----

select e1.emp_id, e1.emp_name,e1.dept_id,d.dept_name,s1.salary
from cleaned_employees e1   
INNER JOIN cleaned_salaries s1  
on e1.emp_id = s1.emp_id
INNER JOIN cleaned_departments d 
on e1.dept_id = d.dept_id 
where s1.salary > ( select avg(s.salary) as avg_salary 
                   from cleaned_salaries s 
                   INNER JOIN cleaned_employees e  
                   on e.emp_id = s.emp_id
                   where e.dept_id = e1.dept_id);

 --- 2.  List employees whose salary is equal to the highest salary in their department ---

select e1.emp_id, e1.emp_name,e1.dept_id,d.dept_name,s1.salary
from cleaned_employees e1   
INNER JOIN cleaned_salaries s1  
on e1.emp_id = s1.emp_id
INNER JOIN cleaned_departments d 
on e1.dept_id = d.dept_id 
where s1.salary = ( select max(salary) from cleaned_salaries s  
                    INNER JOIN cleaned_employees e  
                    on e.emp_id = s.emp_id  
                    where  e.dept_id = e1.dept_id );

--- 3. List all employees whose salary is equal to the lowest salary in their department ----

select e1.emp_id, e1.emp_name,e1.dept_id,d.dept_name,s1.salary
from cleaned_employees e1   
INNER JOIN cleaned_salaries s1  
on e1.emp_id = s1.emp_id
INNER JOIN cleaned_departments d 
on e1.dept_id = d.dept_id 
where s1.salary = ( select min(salary) from cleaned_salaries s  
                    INNER JOIN cleaned_employees e  
                    on e.emp_id = s.emp_id  
                    where  e.dept_id = e1.dept_id );                 