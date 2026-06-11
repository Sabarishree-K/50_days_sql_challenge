
use [50_days_sql_challenge];

EXEC sp_help cleaned_employees;

--- data type conversion for employees table ----

update cleaned_employees
set emp_name = TRIM(emp_name);

alter table cleaned_employees
alter column emp_id int;

alter table cleaned_employees
alter column emp_name varchar(100);

alter table cleaned_employees
alter column age int;

alter table cleaned_employees
alter column city varchar(50);

alter table cleaned_employees
alter column dept_id int;

---- datatype conversion for departments table -----

  EXEC sp_help cleaned_departments; 

  alter table cleaned_departments
  alter column dept_id int;

  alter table cleaned_departments
  alter column dept_name varchar(100); 


  ---- datatype conversion for salaries table -----

  EXEC sp_help cleaned_salaries; 

  select * from cleaned_salaries;

  alter table cleaned_salaries
  alter column salary_id int;

  alter table cleaned_salaries
  alter column emp_id int; 

  alter table cleaned_salaries
  alter column salary int; 

    ---- datatype conversion for attendance table -----

  EXEC sp_help cleaned_attendance; 

  select * from cleaned_attendance;

  alter table cleaned_attendance
  alter column attendance_id int;

  alter table cleaned_attendance
  alter column emp_id int; 

  alter table cleaned_attendance
  alter column status varchar(10); 

  --- datatype conversion for performance table -----

  EXEC sp_help cleaned_performance; 

  select * from cleaned_performance;

  alter table cleaned_performance
  alter column emp_id int; 

  alter table cleaned_performance
  alter column rating_2022 int;

  alter table cleaned_performance
  alter column rating_2023 int;

  alter table cleaned_performance
  alter column rating_2024 int;