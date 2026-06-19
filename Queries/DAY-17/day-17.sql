use [50_days_sql_challenge];

--- 1. List employees with more than 2 salary records ---

select e.emp_id,e.emp_name,count(s.salary_id) as Salary_record_count
from cleaned_employees e  
INNER JOIN cleaned_salaries s   
on e.emp_id=s.emp_id
GROUP BY e.emp_id,e.emp_name 
HAVING count(s.salary_id) > 2;

--- 2. List departments with more than 3 employees ---

SELECT d.dept_name, count(e.emp_id) as employee_count
from cleaned_departments d   
INNER JOIN cleaned_employees e   
on d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING count(e.emp_id) > 3;

--- 3. List employees with total salary greater than 100000 ----

select e.emp_id,e.emp_name, SUM(s.salary) as Total_salary
from cleaned_employees e    
INNER JOIN cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.emp_id,e.emp_name 
HAVING sum(s.salary) > 100000;

--- 4. List departments with high average salary (greater than 50000) ---

select e.dept_id, avg(s.salary) as Avg_salary
from cleaned_employees e  
INNER JOIN cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.dept_id
HAVING avg(s.salary) > 50000;