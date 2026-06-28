use [50_days_sql_challenge];

--- 1. Show current salary along with next salary for each employee ---

select emp_id, salary_date, salary,
       lead(salary) over(partition by emp_id order by salary_date) as next_salary
from cleaned_salaries;

--- 2. Compare current salary with next salary for growth analysis ---

select emp_id, salary_date,salary as current_salary,
       lead(salary) over (partition by emp_id order by salary_date) as next_salary,
       ((lead(salary) over (partition by emp_id order by salary_date))-salary) as salary_difference
from cleaned_salaries;

--- 3. Predict attendance trend by comparing current and next status ---

select emp_id, attendance_date, status as current_status,
        lead(status) over (partition by emp_id order by attendance_date) as next_status
from cleaned_attendance;