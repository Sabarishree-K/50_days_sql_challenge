use [50_days_sql_challenge];

--- 1. Create BEFORE INSERT trigger to prevent negative salary insertion  and 
---    Automatically convert negative salary values to 0 before inserting data ----

create trigger trig_prevent_neg_sal_insert
on cleaned_salaries
instead of INSERT
as 
BEGIN 
    set nocount on;

    insert into cleaned_salaries (salary_id,emp_id,salary,salary_date,is_outlier)
    select
    salary_id, 
    emp_id,
    case when  salary < 0 then  0
    else salary
    end,
    salary_date,
    is_outlier
    from inserted;

end;

Go

insert into cleaned_salaries values (501,362,68000,'2026-06-28',0),
                                    (502,264,-65000,'2026-06-28',0);

select *  from cleaned_salaries where salary_id in (501,502)


--- 2.  Create AFTER UPDATE trigger to track salary changes and 
---     Store old salary and new salary records inside salary_logs table ----

create table salary_logs (emp_id int,old_salary int,new_salary int);

create trigger trig_track_sal_change
on cleaned_salaries

after UPDATE 
as 

begin   

    set NOCOUNT on;

    insert into salary_logs(emp_id,old_salary,new_salary)
    select d.emp_id, d.salary , i.salary
    from deleted d
    inner join  inserted i on d.salary_id = i.salary_id ;

end;

    update cleaned_salaries
    set salary = 99500
    where emp_id = 463

select * from cleaned_salaries where emp_id =463

select * from salary_logs
