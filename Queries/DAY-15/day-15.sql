use [50_days_sql_challenge];

--- 1. List employees with salary records (at least once) -----

select e.emp_id,e.emp_name 
from cleaned_employees e  
where EXISTS
(select * from cleaned_salaries s  
where s.emp_id = e.emp_id);


--- 2. List employees without salary records ----

select e.emp_id,e.emp_name 
from cleaned_employees e  
where NOT EXISTS
(select * from cleaned_salaries s  
where s.emp_id = e.emp_id);

--- 3. List employees with attendance records ----

select e.emp_id, e.emp_name 
from cleaned_employees e
where exists 
(select * from cleaned_attendance a   
where e.emp_id = a.emp_id);  

 --- 4.  List employees without attendance records ---

select e.emp_id, e.emp_name 
from cleaned_employees e
where not exists 
(select * from cleaned_attendance a   
where e.emp_id = a.emp_id);  

