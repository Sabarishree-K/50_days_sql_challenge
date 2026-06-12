
use [50_days_sql_challenge];

--- 1. What are the performance ratings of each employee? ---

select e.emp_id, e.emp_name, 
       p.rating_2022, p.rating_2023, p.rating_2024
from cleaned_employees e  
INNER JOIN cleaned_performance p  
on e.emp_id = p.emp_id;

--- 2. Which employees do not have any salary records? ---

select e.emp_id,e.emp_name,d.dept_name,s.salary
from cleaned_employees e  
inner join cleaned_departments d  
on e.dept_id = d.dept_id
LEFT JOIN  cleaned_salaries s  
on e.emp_id = s.emp_id 
where s.salary is null;

--- 3. Which employees do not have any attendance records? ----

select e.emp_id, e.emp_name, a.status, a.attendance_date  
from cleaned_employees e  
LEFT JOIN cleaned_attendance a  
on e.emp_id = a.emp_id
where a.status is null;

--- 4. What is the employee name, department, and salary together? ---

select e.emp_id,e.emp_name,d.dept_name,s.salary 
from cleaned_employees e 
INNER JOIN cleaned_departments d  
on e.dept_id = d.dept_id
INNER JOIN cleaned_salaries s  
on  e.emp_id = s.emp_id ;

