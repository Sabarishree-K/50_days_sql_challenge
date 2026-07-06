use [50_days_sql_challenge];

--- 1. Find employees whose total salary is greater than 100000 ---


with emp_tot_sal_cte as 
(
select emp_id,sum(salary) as emp_tot_sal from  
cleaned_salaries
group by emp_id
)
select * from emp_tot_sal_cte
where emp_tot_sal > 100000
order by emp_tot_sal desc;

--- 2. Show employee salary along with department average salary using CTE  ---

with dept_avg_sal_cte as  
( 
select e.dept_id,avg(s.salary) as dept_avg_sal
from cleaned_employees e  
inner join cleaned_salaries s on e.emp_id = s.emp_id 
group by e.dept_id
) 
select e1.emp_id, e1.emp_name,d.dept_name,s1.salary,dept_avg_sal
from cleaned_employees e1
inner join cleaned_departments d on e1.dept_id = d.dept_id
inner join cleaned_salaries s1 on e1.emp_id = s1.emp_id
inner join dept_avg_sal_cte  t on e1.dept_id = t.dept_id
order by dept_name;

--- 3.  Find department with highest total salary ---

with dept_tot_sal_cte as
(
select e.dept_id, sum(s.salary) as dept_tot_sal
from cleaned_employees e  
inner join cleaned_salaries s on e.emp_id = s.emp_id
group by e.dept_id
)

select top 1 d.dept_id,d.dept_name,dept_tot_sal 
from dept_tot_sal_cte t 
inner join cleaned_departments d on d.dept_id = t.dept_id
order by dept_tot_sal desc;