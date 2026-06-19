use [50_days_sql_challenge];

--- 1. List employees whose average performance rating is greater than 4 ---

SELECT e.emp_id,e.emp_name,d.dept_name,
       (p.rating_2022 + p.rating_2023 + p.rating_2024)/3.0 as avg_Performance_rating
FROM cleaned_employees e   
INNER JOIN cleaned_performance p on e.emp_id = p.emp_id
INNER JOIN cleaned_departments d on e.dept_id = d.dept_id
where  (p.rating_2022 + p.rating_2023 + p.rating_2024)/3.0  > 4


--- 2.List employees with more than 2 present days ----

SELECT e.emp_id,e.emp_name,d.dept_name,
       count(a.attendance_id) as Present_day_count
FROM cleaned_employees e  
INNER JOIN cleaned_attendance a  on e.emp_id = a.emp_id
INNER JOIN cleaned_departments d on e.dept_id = d.dept_id
where a.status = 'present'
GROUP BY e.emp_id,e.emp_name,d.dept_name
HAVING count(a.attendance_id) > 2

--- 3. List departments where total salary paid is greater than 200000 ---

select e.dept_id,sum(s.salary) as Total_salary
from cleaned_employees e 
INNER JOIN cleaned_salaries s  
on e.emp_id = s.emp_id
GROUP BY e.dept_id
having  sum(s.salary) > 200000


--- 4. List employees whose total salary is greater than their department average salary ---

with emp_total_salary as 
(
    select e.emp_id,e.emp_name,e.dept_id,sum(s.salary) as Total_salary
    from cleaned_employees e 
    INNER JOIN cleaned_salaries s  
    on e.emp_id = s.emp_id
    GROUP BY e.emp_id,e.emp_name,e.dept_id )

select * from emp_total_salary ets
where Total_salary > ( select avg(total_salary) from 
                       emp_total_salary ets2
                       where ets2.dept_id = ets.dept_id) ;

