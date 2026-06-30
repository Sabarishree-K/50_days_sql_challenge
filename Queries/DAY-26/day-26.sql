use [50_days_sql_challenge];

--- 1. Find rank of employees within each department based on salary ---

select e.emp_id,e.emp_name,d.dept_name,s.salary,
       DENSE_RANK() over (partition by e.dept_id order by salary desc) as Dept_salary_rank 
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id;

--- 2. Compare each employee’s salary with their department average (Above Avg / Below Avg / Equal) ---

select e.emp_id,e.emp_name,d.dept_name,s.salary,
        avg(s.salary) over (partition by e.dept_id) as dept_avg_salary, 
        case when (salary - avg(s.salary) over (partition by e.dept_id)) = 0 then 'Equal'
             when (salary - avg(s.salary) over (partition by e.dept_id)) > 0 then 'Above Avg'
             when (salary - avg(s.salary) over (partition by e.dept_id)) < 0 then  'Below Avg'
        end as category
from cleaned_employees e  
inner join cleaned_departments d on e.dept_id = d.dept_id
inner join cleaned_salaries s on e.emp_id = s.emp_id 

--- 3.  Find top 3 highest paid employees in each department ---

select * FROM
  ( select e.emp_id,e.emp_name,e.city,d.dept_name,s.salary,
            DENSE_RANK() over (partition  by e.dept_id order by s.salary desc)  as Dept_salary_rank
    from cleaned_employees e  
    inner join cleaned_departments d on e.dept_id = d.dept_id
    inner join cleaned_salaries s on e.emp_id = s.emp_id  
  ) t 
where Dept_salary_rank <= 3  

--- 4. Find lowest salary employee in each department ---

select * FROM
  ( select e.emp_id,e.emp_name,e.city,d.dept_name,s.salary,
            DENSE_RANK() over (partition  by e.dept_id order by s.salary)  as Dept_salary_rank
    from cleaned_employees e  
    inner join cleaned_departments d on e.dept_id = d.dept_id
    inner join cleaned_salaries s on e.emp_id = s.emp_id  
  ) t 
where Dept_salary_rank <= 3  


