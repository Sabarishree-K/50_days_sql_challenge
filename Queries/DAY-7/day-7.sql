
use [50_days_sql_challenge];

--- check for invalid dates ----

--- In employees table -----

select * from cleaned_employees
where TRY_CONVERT(date,hire_date,105) is null;

--- update hire_date as null for those invalid dates ---

update cleaned_employees 
set hire_date = null
where TRY_CONVERT(date,hire_date,105) is null;

select * from cleaned_employees 
where hire_date is null ;

--- change the date format from dd-mm-yyy to yyyy-mm-dd ---

BEGIN TRANSACTION;

update cleaned_employees
set hire_date = CONVERT(varchar(10),CONVERT(date,hire_date,105),23)
where TRY_CONVERT(date,hire_date,105) is not null;

select * from cleaned_employees 
where hire_date is not null ;

---- Replace all null and empty date values with 2024-02-25 --

update cleaned_employees
set hire_date = '2024-02-25'
where hire_date is null;

--- change the data type of hire_date column to date ----

alter table cleaned_employees 
alter column hire_date date;

--- In salaries table ----

---check for invalid salary date using try_convert() ---
---- 105 is the code that specifies input date in dd-mm-yyyy format ---

select * from cleaned_salaries 
where TRY_CONVERT(date,salary_date,105) is null 
or salary_date is null;

--- update the inalid date to null ----
update cleaned_salaries
set salary_date = null
where TRY_CONVERT(date,salary_date,105) is NULL;

select * from cleaned_salaries
where salary_date is null;

---- replace the null values to the referrence date '2024-02-25' ----

update cleaned_salaries
set salary_date = '2024-02-25'
where salary_date is null

---- change the date format to yyyy-mm-dd -----

update cleaned_salaries 
set  salary_date = CONVERT(varchar(10), CONVERT(date,salary_date,105),23)
where TRY_CONVERT(date,salary_date,105) is not null;


--- change the data type of salary_date column to date ----

alter table cleaned_salaries 
alter column salary_date date;

----- In attendance table ----
---- check for invalid date or ( empty or null ) date field----

select * from cleaned_attendance
where TRY_CONVERT(date,attendance_date,105) is null 
or attendance_date is null;

---change the date format to yyyy-mm-dd and  datatype to date ----

update cleaned_attendance
set attendance_date = CONVERT(varchar(10),convert(date,attendance_date,105),23)
where try_convert(date,attendance_date,105) is not null;

alter table cleaned_attendance
alter column attendance_date date;

COMMIT;

select @@TRANCOUNT;