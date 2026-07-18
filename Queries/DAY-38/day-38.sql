use [50_days_sql_challenge];

--- 1. Create BEFORE UPDATE trigger to prevent negative salary updates ---

create trigger trig_neg_sal_update
on cleaned_salaries
instead of update 
as
begin  
    set nocount on ;
    
    update s 
    set salary = 
        case 
            when i.salary < 0 then d.salary
            else i.salary
        end 
    from cleaned_salaries s 
    inner join inserted i on s.emp_id = i.emp_id
    inner join deleted d on s.emp_id = d.emp_id
end;


select * from cleaned_salaries where emp_id = 164;

update cleaned_salaries 
set salary = -40000 where emp_id = 164;

--- 2. Create AFTER INSERT trigger to log attendance records automatically ---

create table attendance_logs (emp_id int, attendance_date date, message varchar(100));

create trigger trig_insert_attendance_log
on cleaned_attendance

after insert 
as 

begin  
    set nocount on;

    insert into attendance_logs(emp_id, attendance_date,message)
    select emp_id,attendance_date,'Attendance added'
    from inserted ;

end;
GO

insert into cleaned_attendance values (705,101,'present','2026-08-06')

select * from attendance_logs

select * from cleaned_attendance where emp_id = 101