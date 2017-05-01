--a
select m.employee_id, count(m.employee_id) 
from employees m, employees e 
where e.manager_id = m.employee_id 
group by employee_id 
order by count(m.employee_id) desc;


--b
select d.department_name, count(*), sum(e.salary)
from departments d, locations l, countries c, employees e 
where d.location_id = l.location_id 
and l.country_id = c.country_id 
and c.country_name <> 'United States of America'
and e.department_id = d.department_id
group by d.department_name
having count(*) < 100;


--c
select d.department_name, m.first_name || ' ' || m.last_name as manager_name, j.job_title
from departments d left outer join employees m
on d.manager_id = m.employee_id
join jobs j
on m.job_id = j.job_id;


--d
select d.department_name, avg(e.salary)
from departments d left outer join employees e
on d.department_id = e.department_id
group by d.department_name
order by avg(e.salary) desc;