
use [50_days_sql_challenge];

-- 1. Categorize employees based on salary (Low / Medium / High) ----

select emp_id, salary, 
CASE 
     when salary < 30000 then 'Low'
     when salary between 30000 and 60000 then 'Medium'
else 
     'High'
 end  as Category

from cleaned_salaries
order by Salary desc;       

-- 2. Categorize employees based on performance rating (Good / Average / Poor) ---

select emp_id, (rating_2022 + rating_2023 + rating_2024)/3 as avg_rating,
case 
    when ((rating_2022 + rating_2023 + rating_2024)/3 ) >= 4 then 'Good'
    when ((rating_2022 + rating_2023 + rating_2024)/3 ) >= 3 then  'Average'
else 'Poor'
end as Category
from cleaned_performance
order by avg_rating desc;

-- 3. Categorize employees based on attendance status (Active / Inactive) ----

select emp_id, status,attendance_date,
case 
    when status = 'present' then ' Active'
else 'Inactive'
end as Category
from cleaned_attendance
order by attendance_date desc;

-- 4. Categorize employees based on experience level (Fresher / Mid-Level / Experienced) ---

select emp_id, emp_name,hire_date, year(CURRENT_DATE)- YEAR(hire_date) as experience_years,
case   
    when year(CURRENT_DATE)- YEAR(hire_date) < 2 then 'Fresher'
    when year(CURRENT_DATE)- YEAR(hire_date) between 2 and 5 then 'Mid-Level'
else 'Experienced'
end as Category
from cleaned_employees
order by experience_years desc;