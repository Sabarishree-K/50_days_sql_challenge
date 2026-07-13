
use [50_days_sql_challenge];

--- 1. Create a procedure to get all employee data ---

create procedure get_all_emp
as 
begin  
    select * from cleaned_employees;
end;
Go  

exec get_all_emp;

--- 2. Create a procedure with input parameter to find employee by emp_id ---

create procedure get_emp_details
        @emp_id int 
as 
begin  
    select * from cleaned_employees 
    where emp_id = @emp_id;
end;
Go 

exec get_emp_details 122;

--- 3. Create a procedure using JOIN to fetch employee and salary details ---

create procedure get_emp_sal_details
as  
begin  
    select e.emp_id,e.emp_name,e.age,e.city,e.dept_id,s.salary
    from cleaned_employees e  
    inner join cleaned_salaries s on e.emp_id = s.emp_id;
end;
Go  

exec get_emp_sal_details;

--- 4. Create a procedure for salary report (employees with salary > 50000) ---

create procedure get_salary_report 
as 
begin  
    select e.emp_id,e.emp_name,e.city,e.dept_id,s.salary 
    from cleaned_employees e  
    inner join cleaned_salaries s on e.emp_id = s.emp_id 
    where s.salary > 50000
    order by s.salary desc;
end;
GO 

exec get_salary_report;