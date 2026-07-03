use [50_days_sql_challenge];

--- 1. Find latest salary per employee along with total salary till that point ---

select * from
(select e.emp_id,e.emp_name,d.dept_name,s.salary as latest_salary,
        AVG(s.salary) over (partition by e.dept_id) as dept_avg_salary,
        sum(s.salary) over (partition by e.emp_id )as total_salary,
        dense_rank() over (partition by e.emp_id order by salary_date desc) as Emp_salary_rank
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id) t
where Emp_salary_rank = 1;
 
--- 2. Rank employees based on salary and compare with department average salary

select e.emp_id,e.emp_name,d.dept_name,s.salary, 
        AVG(s.salary) over (partition by e.dept_id) as dept_avg_salary,
        dense_rank() over (partition by e.emp_id order by salary_date desc) as Emp_salary_rank,
        case when s.salary >  AVG(s.salary) over (partition by e.dept_id) then 'Above Dept_Avg'
             when s.salary <  AVG(s.salary) over (partition by e.dept_id) then 'Below Dept_Avg'
        else 'equal'
        end as Category
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id;

---- 3. Check whether salary has increased or decreased compared to previous record ----

select * from
(select e.emp_id,e.emp_name,d.dept_name,s.salary as current_salary, 
        lead(s.salary) over (partition by e.emp_id order by salary_date) as Previous_salary,
        case when s.salary >  lead(s.salary) over (partition by e.emp_id order by salary_date) then 'Increased'
             when s.salary <  lead(s.salary) over (partition by e.emp_id order by salary_date) then 'Decreased'
        else 'Same as previous_Salary'
        end as Category
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id) t 
where Previous_salary is NOT NULL;