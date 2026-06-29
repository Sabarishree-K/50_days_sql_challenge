use [50_days_sql_challenge];

--- 1. Calculate running total salary for each employee over time ----

select emp_id,salary_date,salary,
       sum(salary) over (partition by emp_id order by salary_date) as running_tot_salary
from cleaned_salaries;

--- 2. Calculate running attendance count for each employee ---

select emp_id, attendance_date,status,
        count(attendance_date) over (partition by emp_id order by attendance_date) as running_attendance_cnt
from cleaned_attendance;

--- 3. Calculate cumulative salary for each department over time ---

select e.emp_id,d.dept_name,s.salary,
        sum(s.salary) over(partition by e.dept_id order by s.salary_date) as cumulative_salary
from cleaned_employees e  
INNER JOIN cleaned_salaries s  on e.emp_id = s.emp_id
INNER JOIN cleaned_departments d on e.dept_id = d.dept_id;