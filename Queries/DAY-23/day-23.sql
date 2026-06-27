use [50_days_sql_challenge];

--- 1. Show current salary along with previous salary for each employee ---

select emp_id, salary_date, salary,
       lag(salary) over(partition by emp_id order by salary_date) as previous_salary
from cleaned_salaries;

--- 2. Calculate difference between current salary and previous salary ---

select emp_id, salary_date,salary as current_salary,
       lag(salary) over (partition by emp_id order by salary_date) as previous_salary,
       (salary - (lag(salary) over (partition by emp_id order by salary_date))) as salary_difference
from cleaned_salaries;

--- 3. Analyze attendance trend (compare current status with previous status) ----

select emp_id, attendance_date, status as current_status,
        lag(status) over (partition by emp_id order by attendance_date) as previous_status
from cleaned_attendance;