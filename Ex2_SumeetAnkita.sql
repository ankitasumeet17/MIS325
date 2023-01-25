/*
Internship
*/

select business_process_type, 31 from workday.staffing_events
where
business_process_type in ('Hire’, ‘Contract Contingent Worker') and
date_trunc ('year', effective_date) = '1/1/2022' and
function_proposed = 'Engineering;

select
date_trunc ('month', effective_date) as hire_month,
count (distinct employee_id) as hires
from workday.staffing_events
where
business_process_type in ('Hire', 'Contract Contingent Worker') and
date_trunc ('year', effective_date) = '1/1/2022
group by hire_month;

select *
from workday. trended_worker_snapshot
where worker like '%Wessel%'
order by effective_date asc;