use [50_days_sql_challenge];

--- 1. Create temporary table for employee salary summary ---

create table #temp_sal_summary (emp_id int, total_salary int);

--- 2. Insert aggregated salary data into temporary table ---

insert into #temp_sal_summary (emp_id,total_salary)
select emp_id,sum(salary)
from cleaned_salaries
group by emp_id;

select * from #temp_sal_summary;

--- 3. Join temporary table with employee table to fetch employee details ---

select e.emp_id, e.emp_name, t.total_salary
from cleaned_employees e  
inner join #temp_sal_summary t 
on e.emp_id = t.emp_id
order by total_salary desc;

--- 4.Drop temporary table after usage ----

drop table #temp_sal_summary;

SELECT * from #temp_sal_summary