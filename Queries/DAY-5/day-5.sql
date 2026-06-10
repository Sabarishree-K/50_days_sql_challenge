
--- check for invalid data---

--- invalid age (rule : min - 18 and max - 65) ---

select * from cleaned_employees
where (age < 18 or age > 65)

--- invalid salary (salary < 0) ---

select * from cleaned_salaries 
where salary < 0

--- invalid rating (rule: min - 0 and max - 5) ---

select * from cleaned_performance
where rating_2022 < 0 or rating_2022 > 5

select * from cleaned_performance
where rating_2023 < 0 or rating_2023 > 5

select * from cleaned_performance
where rating_2024 < 0 or rating_2024 > 5


---- fix invalid age ----

update cleaned_employees 
set age = case 
when emp_id = 20 then 32
when emp_id = 24 then 28
when emp_id = 44 then 35
when emp_id = 65 then 40
when emp_id = 66 then 30
when emp_id = 67 then 27
when emp_id = 110 then 38
when emp_id = 134 then 29
when emp_id = 147 then 33
when emp_id = 188 then 36
when emp_id = 216 then 31
when emp_id = 223 then 26
when emp_id = 266 then 42
when emp_id = 295 then 34
when emp_id = 318 then 28
when emp_id = 347 then 37
when emp_id = 360 then 39
when emp_id = 387 then 25
when emp_id = 420 then 41
when emp_id = 428 then 33   
when emp_id = 440 then 29
when emp_id = 460 then 36
when emp_id = 466 then 27
when emp_id = 469 then 32
when emp_id = 471 then 35
else age
end

--- fix invalid salary ---

update cleaned_salaries 
set salary = case 
when emp_id = 463 then 55000
when emp_id = 142 then 60000
when emp_id = 100 then 45000
when emp_id = 30 then 70000
when emp_id = 54 then 52000
when emp_id = 310 then 48000
when emp_id = 183 then 51000
when emp_id = 168 then 47000
when emp_id = 126 then 46000
when emp_id = 206 then 58000
when emp_id = 76 then 49000
when emp_id = 433 then 62000
when emp_id = 43 then 53000
when emp_id = 324 then 55000
when emp_id = 226 then 51000
when emp_id = 113 then 50000
when emp_id = 273 then 52000
when emp_id = 200 then 48000
when emp_id = 160 then 47000
when emp_id = 42 then 46000
when emp_id = 150 then 49000  
when emp_id = 45 then 53000
when emp_id = 65 then 54000
when emp_id = 488 then 60000
when emp_id = 8 then 45000
when emp_id = 121 then 50000
when emp_id = 78 then 47000
when emp_id = 94 then 46000
when emp_id = 353 then 52000
else salary
end