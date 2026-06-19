use [50_days_sql_challenge];

--- 1. Calculate total salary paid to each employee ---

select e.emp_id,e.emp_name,SUM(s.salary) as Total_salary 
from cleaned_employees e   
inner join cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.emp_id,e.emp_name

--- 2. Calculate average salary of each employee ----

select e.emp_id,e.emp_name,avg(s.salary) as Avg_salary 
from cleaned_employees e   
inner join cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.emp_id,e.emp_name

--- 3. Count number of salary records for each employee ----

select e.emp_id,e.emp_name,count(s.salary_id) as Salary_record_count 
from cleaned_employees e   
inner join cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.emp_id,e.emp_name

--- 4. Find maximum salary received by each employee ----

select e.emp_id,e.emp_name,max(s.salary) as max_salary
from cleaned_employees e   
inner join cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.emp_id,e.emp_name