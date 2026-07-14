use [50_days_sql_challenge];

--- 1. Create procedure with IF condition to return message based on salary ---

create procedure salary_check
        @emp_id int 
as 
begin  
    declare @sal int;
    select top 1 
     @sal = salary
     from cleaned_salaries 
    where emp_id = @emp_id;

if @sal > 50000 
BEGIN 
    select 'high salary' as result
END
else
BEGIN
    select 'low salary' as result
END 

end;
Go 

exec salary_check 123;

---2. Create procedure with CASE statement to categorize employees (High / Medium / Low) ---

create procedure categorize_emp
        @emp_id int 
as 
begin  
    select top 1 salary,
            CASE WHEN salary > 70000 then 'high salary'
            when salary > 40000 then 'medium salary'
            else 'low salary'
            end as category
    from cleaned_salaries 
    where emp_id = @emp_id;
  
end;
GO

exec categorize_emp 282

--- 3. Create procedure with aggregation to calculate total salary per employee ----

create procedure emp_total_salary
        @emp_id int 
as 
begin  
    select emp_id,sum(salary) as total_salary           
    from cleaned_salaries 
    where emp_id = @emp_id
    group by emp_id;
  
end;
GO

exec emp_total_salary 2;

