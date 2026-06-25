
use [50_days_sql_challenge];

-- 1. Rank employees based on salary ---

select emp_id,salary,DENSE_RANK() over (order by salary desc) as salary_rank 
from cleaned_salaries

-- 2.  Perform department-wise ranking of employees ---
  
select e.emp_id,e.emp_name,e.age,d.Dept_name,s.salary,
       DENSE_RANK() over (partition by d.dept_id order by s.salary desc) as dept_rank
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id


--- 3. Identify top performers based on average performance rating ----

select e.emp_id,e.emp_name,(p.rating_2022+p.rating_2023+p.rating_2023)/3 as avg_rating,
             DENSE_RANK() over (order by (p.rating_2022 + p.rating_2023 + p.rating_2023)/3 desc ) as rating_rank
from cleaned_employees e  
inner join cleaned_performance p on e.emp_id = p.emp_id


--- 4. Find top 3 employees based on salary ranking ----

select top 3 e.emp_id,e.emp_name,e.age,e.city,d.Dept_name,s.salary,
             DENSE_RANK() over (order by s.salary desc) as salary_rank 
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id 

--- 5. Find top 3 employees from each dept based on salary ranking ----

select * from 
(
    select e.emp_id,e.emp_name,e.age,e.city,d.Dept_name,s.salary,
                DENSE_RANK() over ( partition by e.dept_id order by s.salary desc) as rank_num 
    from cleaned_employees e  
    inner join cleaned_departments d on e.dept_id = d.dept_id
    inner join cleaned_salaries s on e.emp_id = s.emp_id ) t  

where rank_num <= 3

