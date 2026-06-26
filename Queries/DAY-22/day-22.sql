
use [50_days_sql_challenge];

--- 1. Show each employee with average salary of their department ----

--- with windows function ----

select *,avg( t.salary) over(partition by t.dept_name) as dept_avg_salary from
(select e.emp_id,e.emp_name,d.dept_name,s.salary 
from cleaned_employees e  
inner join cleaned_salaries s on e.emp_id = s.emp_id 
inner join cleaned_departments d on e.dept_id = d.dept_id) t 

--- with cte -----

with cte as 
(   select e1.dept_id,avg(s.salary) as dept_avg_salary
    from cleaned_salaries s 
    inner join cleaned_employees e1 on e1.emp_id = s.emp_id
    group by e1.dept_id  )

select e.emp_id,e.emp_name,d.dept_name,s.salary,cte.dept_avg_salary
from cleaned_employees e  
inner join cleaned_salaries s on e.emp_id = s.emp_id 
inner join cleaned_departments d on e.dept_id = d.dept_id 
inner join cte on e.dept_id = cte.dept_id
ORDER BY dept_name

--- 2. Show total salary of each department for every employee ----

select *,sum ( t.salary) over(partition by t.dept_name) as dept_total_salary from
(select e.emp_id,e.emp_name,d.dept_name,s.salary 
from cleaned_employees e  
inner join cleaned_salaries s on e.emp_id = s.emp_id 
inner join cleaned_departments d on e.dept_id = d.dept_id) t 


--- 3.  Show average performance rating of each department ----

select d.dept_name, avg((p.rating_2022 + p.rating_2023 + p.rating_2024)/3.0 ) as dept_avg_perform_rating  
from cleaned_employees e 
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_performance p on e.emp_id = p.emp_id
group by dept_name
order by dept_avg_perform_rating desc;

--- 4. show average performance rating of each dept for every employee -----

select e.emp_id,e.emp_name,d.dept_name, 
      (p.rating_2022 + p.rating_2023 + p.rating_2024)/3.0  as avg_perform_rating,
      avg((p.rating_2022 + p.rating_2023 + p.rating_2024)/3.0 ) over(partition by dept_name) as dept_avg_perform_rating  
from cleaned_employees e 
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_performance p on e.emp_id = p.emp_id
order by dept_name


