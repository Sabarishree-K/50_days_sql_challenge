use [50_days_sql_challenge];

--- 1.What is the employee name, department, and performance ratings? ----

select e.emp_id,e.emp_name,d.dept_name, 
       p.rating_2022,p.rating_2023,p.rating_2024
from cleaned_employees e  
INNER JOIN cleaned_departments d  
on e.dept_id = d.dept_id 
INNER JOIN cleaned_performance p  
on e.emp_id = p.emp_id;

--- 2. What is the complete profile of each employee (department, salary, performance)?

select e.emp_id,e.emp_name,d.dept_name,
       s.salary,s.salary_date,
       p.rating_2022,p.rating_2023,p.rating_2024
from cleaned_employees e  
INNER JOIN cleaned_departments d  
on e.dept_id = d.dept_id 
INNER JOIN cleaned_salaries s  
on e.emp_id = s.emp_id
INNER JOIN cleaned_performance p  
on e.emp_id = p.emp_id;

--- 3. How many salary records does each employee have?  ------

select e.emp_id,e.emp_name,count(s.emp_id) as salary_records_count 
from cleaned_employees e   
LEFT JOIN cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.emp_id,e.emp_name;

---- 4. What is the total salary paid to each employee? ----

select e.emp_id,e.emp_name,SUM(s.salary) as total_salary
from cleaned_employees e   
INNER JOIN cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.emp_id,e.emp_name;


