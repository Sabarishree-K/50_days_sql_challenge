
use [50_days_sql_challenge];

--- change the datatype of salary column to int ----

alter table cleaned_salaries
alter column salary int;

--- detect outliers ----

--- calculate min, max and avg salaries ----

select min(salary) as min_salary,
       max(salary) as max_salary,
       avg(salary) as avg_salary 
from cleaned_salaries
where salary > 0;

---  client rules min salary - 20000 & max salary - 2,00,000 ---

select * from cleaned_salaries
where ( salary < 20000 or salary > 200000 );

--- add outlier column in salaries table -----

alter table cleaned_salaries
add is_outlier int;

---- populate 1 for outlier and 0 for rest of the salaries ----

update cleaned_salaries 
set is_outlier = case 
when ( salary < 20000 or salary > 200000 ) then 1
else 0
end;

select * from cleaned_salaries
where salary_id in (17,37);

--- update the salary of outliers from the reference value ---

update cleaned_salaries
set salary = case 
when salary_id = 17 then 65000
when salary_id = 37 then 97000
else salary
end;