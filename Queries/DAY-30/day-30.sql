use [50_days_sql_challenge];

--- 1.Create a temporary result set using CTE and filter data from it ---

with salary_cte as 
(
select emp_id, salary FROM
cleaned_salaries
)
select * from salary_cte
where salary > 100000
order by salary desc;

---- 2. Combine employees and salaries using CTE -----

with emp_details_cte as
(
select e.emp_id,e.emp_name,e.dept_id,s.salary
from cleaned_employees e  
inner join cleaned_salaries s on s.emp_id= e.emp_id 
)
select * from emp_details_cte 
where dept_id = '6'
order by salary desc;

---- 3.Calculate department average salary using CTE ---

with dept_avg_sal_cte as  
( select e.dept_id,avg(s.salary) as dept_avg_sal
from cleaned_employees e  
inner join cleaned_salaries s on e.emp_id = s.emp_id 
group by e.dept_id) 

select e1.emp_id, e1.emp_name,d.dept_name,s1.salary,dept_avg_sal
from cleaned_employees e1
inner join cleaned_departments d on e1.dept_id = d.dept_id
inner join cleaned_salaries s1 on e1.emp_id = s1.emp_id
inner join dept_avg_sal_cte  t on e1.dept_id = t.dept_id
order by dept_name;


---- 4. Find employees earning more than department average using CTE ----

with dept_avg_sal_cte as  
( select e.dept_id,avg(s.salary) as dept_avg_sal
from cleaned_employees e  
inner join cleaned_salaries s on e.emp_id = s.emp_id 
group by e.dept_id) 

select e1.emp_id, e1.emp_name,d.dept_name,s1.salary,dept_avg_sal
from cleaned_employees e1
inner join cleaned_departments d on e1.dept_id = d.dept_id
inner join cleaned_salaries s1 on e1.emp_id = s1.emp_id
inner join dept_avg_sal_cte  t on e1.dept_id = t.dept_id
where s1.salary > dept_avg_sal;