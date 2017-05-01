--1.a. 
select employees.first_name, employees.last_name from employees, job_history
where employees.employee_id = job_history.employee_id
and job_history.end_date is not null;

--1.b
select distinct e.first_name || ' ' || e.last_name as Employee_Name, 
m.first_name || ' ' || m.last_name as Manager_Name
from employees e, employees m, job_history
where e.manager_id = m.employee_id
and e.hire_date < m.hire_date
and e.employee_id = job_history.employee_id
and m.department_id = job_history.department_id;

--1.c
--Join query:
select distinct Countries.country_name
from Departments, Locations, Countries
where Departments.location_id = Locations.location_id
and Locations.country_id = Countries.country_id;

--Nested query:
select distinct Countries.country_name from Countries, Locations
where Countries.country_id = Locations.country_id and Locations.location_id in
(select Locations.location_id from Departments
	where Locations.location_id = Departments.location_id);
	
--I think that the first query is better because it seemed like a more natural
--way to get this data, and with the way that Oracle optimizes joins, I don't think
--that performance will take a hit from joining the three tables at once.