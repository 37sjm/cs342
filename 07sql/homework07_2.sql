drop materialized view matempview;


create materialized view matempview as
select e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
from employees e, departments d
where d.department_id = e.department_id;


--7.2.a
select first_name, last_name, employee_id from matempview where rownum = 1 order by hire_date desc;


--7.2.b
update matempview set department_name = 'Bean Counting' where department_name = 'Accounting';
--Once again we get an error, this one says "data manipulation is not legal on this view"
--This view is also blocked from being updatable (I tried to use the "for update" syntax that is on
--the lab directions because of the following error:
--ORA-12013: updatable materialized view must be simple enough and have a 
--materialized view log on its master table to do fast refresh


--7.2.c
 update matempview set first_name = 'Jose' where first_name = 'Jose Manuel';
 --Same error as 7.2.b
 
--7.2.d
 insert into matempview values (1, 'Mitch', 'Stark', 'fake', '28-Mar-2017', 'Bean Counting');
 --same error as 7.2.b and 7.2.c