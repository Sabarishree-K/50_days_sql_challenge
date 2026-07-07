use [50_days_sql_challenge];

--- 1. Update employee data using a view ----

create view emp_basic_view as  
(
    select emp_id, emp_name,dept_id, city 
    from cleaned_employees
);

update emp_basic_view  
set city = 'Mumbai'
where emp_id = 110;

select * from emp_basic_view
where emp_id = 110;


--- 2. Create view for high salary employees (salary > 50000) and fetch data from it ---

create view high_sal_emp_view as  

( select e.emp_id,e.emp_name,e.city,e.dept_id,s.salary,s.salary_date
    from cleaned_employees e  
    inner join cleaned_salaries s on e. emp_id = s.emp_id
    where s.salary > 50000
 );

select * from high_sal_emp_view 
where dept_id = 6
order by salary desc;


--- 3.  Create multi-table view combining employee, department, and salary ---

create view emp_dept_sal_view as 

( 
    select e.emp_id,e.emp_name,e.city,e.dept_id,d.dept_name,s.salary,s.salary_date
    from cleaned_employees e  
    inner join cleaned_departments d on e.dept_id = d.dept_id
    inner join cleaned_salaries s on e. emp_id = s.emp_id
 );

select * from emp_dept_sal_view
where city = 'Pune'
order by salary desc;

--- 4. Create HR dashboard view for high salary employees with department name ---

create view HR_DASHBOARD as  

( 
    select e.emp_id,e.emp_name,e.city,e.dept_id,d.dept_name,s.salary,s.salary_date
    from cleaned_employees e  
    inner join cleaned_departments d on e.dept_id = d.dept_id
    inner join cleaned_salaries s on e. emp_id = s.emp_id
    where s.salary > 50000
 );

select * from HR_DASHBOARD
where dept_id = 6
order by salary desc;