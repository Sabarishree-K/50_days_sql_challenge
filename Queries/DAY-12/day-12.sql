use [50_days_sql_challenge];

---- 1.What is the average salary in each department? ------

select d.dept_name,avg(s.salary) as Avg_salary
FROM cleaned_departments d
INNER JOIN cleaned_employees e    
on d.dept_id = e.dept_id
INNER JOIN cleaned_salaries s 
on s.emp_id = e.emp_id
GROUP BY d.dept_name;

---- 2. How many days was each employee present? -----

select e.emp_id,e.emp_name, count(a.attendance_id) as No_of_days_present
from cleaned_employees e  
INNER JOIN cleaned_attendance a   
on e.emp_id = a.emp_id
where status in ('present','wfh') 
GROUP BY e.emp_id,e.emp_name



---- 3. Which employees belong to the same department?   -----

select d.dept_name,STRING_AGG(e.emp_name, ',') as employees_list
FROM cleaned_departments d
INNER JOIN cleaned_employees e    
on d.dept_id = e.dept_id
GROUP BY d.dept_name;

---- 4. Which employees have more than one salary record? -----

select e.emp_id,e.emp_name,count(s.salary_id) as Salary_record_count 
from cleaned_employees e   
INNER JOIN cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.emp_id,e.emp_name
HAVING count(s.salary_id) > 1
