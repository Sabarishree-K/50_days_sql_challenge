use [50_days_sql_challenge]
create table departments
         ( dept_id varchar(40),
           dept_name varchar(40)); 
create table employees
         ( 
            emp_id varchar(40),
            emp_name varchar(40),
            age varchar(10),
            city varchar(40),
            dep_id varchar(40),
            hire_date varchar(20) ); 
create table employees
         ( 
            emp_id varchar(40),
            emp_name varchar(40),
            age varchar(10),
            city varchar(40),
            dep_id varchar(40),
            hire_date varchar(20) );

create table salaries
         ( 
            salary_id varchar(40),
            emp_id varchar(40),
            salary varchar(40),
            salary_date varchar(20) );

create table attendance
         ( 
            attendance_id varchar(40),
            emp_id varchar(40),
            status varchar(40),
            attendance_date varchar(20) );


create table performance
         ( 
            emp_id varchar(40),
            rating_2022 varchar(40),
            rating_2023 varchar(40),
            rating_2024 varchar(40) );
