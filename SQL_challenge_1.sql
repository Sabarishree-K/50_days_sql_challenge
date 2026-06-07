select * from departments;
select * from employees;
select * from attendance;
select * from salaries;
select * from performance;

exec sp_rename 'employees.dept-id','dept_id', 'column';
truncate table employees
