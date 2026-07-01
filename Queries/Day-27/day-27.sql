use [50_days_sql_challenge];

---  1.Compare each employee's salary with overall average salary (> avg → Above Avg, < avg → Below Avg,= avg → Equal) ---

select distinct e.emp_id,e.emp_name,d.dept_name,
        sum(s.salary) over (partition by e.emp_id) as emp_total_salary,
        avg(s.salary) over () as overall_avg_salary, 
        case when (sum(s.salary) over (partition by e.emp_id) > avg(s.salary) over ()) then 'Above Avg'
             when (sum(s.salary) over (partition by e.emp_id) < avg(s.salary) over ()) then  'Below Avg' 
        else 'equal'
        end as category
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id 
order by category;

--- 2. Compare employee salary with total salary of all employees (salary > 10% of total salary → High Contributor, else → Low Contributor)  --

select distinct e.emp_id,e.emp_name,d.dept_name,
        sum(s.salary) over () as overall_total_salary, 
        sum(s.salary) over (partition by e.emp_id) as emp_total_salary, 
        case when (sum(s.salary) over (partition by e.emp_id) > ((sum(s.salary) over ())*0.10) ) then 'High Contributor'
        else 'Low Contributor'
        end as category
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id 
order by category;


--- 3. Compare department total salary with overall total salary (dept total > 30% of total → High Dept, else → Low Dept)  --

select  distinct d.dept_name,
        sum(s.salary) over() as total_salary,
        sum(s.salary) over (partition by e.dept_id) as dept_total_salary, 
        ((sum(s.salary) over ())*0.30) as Percent_30_total_salary,
        case when (sum(s.salary) over (partition by e.dept_id) > ((sum(s.salary) over ())*0.30) ) then 'High Dept'
        else 'Low Dept'
        end as category
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id 
order by category;
