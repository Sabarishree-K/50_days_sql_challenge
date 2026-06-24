use [50_days_sql_challenge];

--- 1.Retrieve latest salary record for each employee ----

select * from 
(select *, ROW_NUMBER() over (partition by emp_id order by salary_date desc) as rn
from cleaned_salaries) t
where rn = 1;

--- 2. Retrieve first (oldest) salary record for each employee ----

select * from 
(select * , ROW_NUMBER() over (partition by emp_id order by salary_date) as rn  
from cleaned_salaries)  t
where rn = 1;

--- 3. Rank salary entries for each employee ----

select * FROM
(select *, RANK()over (partition by emp_id order by salary_date desc) as rank 
from cleaned_salaries) t ;

--- 4. Get top 2 salary records per employee  ----

select * FROM
(select * , RANK() over (partition by emp_id order by salary_date desc) as rank 
from cleaned_salaries) t 
where rank < 3

