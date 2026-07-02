use [50_days_sql_challenge];

--- 1. Find top 2 highest paid employees in each department ---

select * from

(select e.emp_id,e.emp_name,d.dept_name,s.salary,
        dense_rank() over (partition by e.dept_id order by salary desc) as Dept_salary_rank 
        from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id)   t  

where dept_salary_rank <=2;

--- 2. Calculate salary gap (difference between current salary and previous salary) ----

select * from
(select e.emp_id,e.emp_name,d.dept_name,s.salary as current_salary,
        lag(s.salary) over (partition by e.emp_id order by s.salary_date) as Previous_salary,
        (s.salary - lag(s.salary) over (partition by e.emp_id order by s.salary_date)) as salary_gap
        from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id ) t  
where salary_gap is NOT NULL

--- 3. Calculate performance gap (change in performance between years) ----

select * , (rating_2023 - rating_2022) as perform_gap_22_23 ,
            (rating_2024 - rating_2023) as perform_gap_23_24 
from cleaned_performance;

--- 4. Filter only top performers based on ranking -----

select * from

(select e.emp_id,e.emp_name,d.dept_name,s.salary,
        dense_rank() over (partition by e.dept_id order by salary desc) as Dept_salary_rank 
        from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id)   t  

where dept_salary_rank = 1;