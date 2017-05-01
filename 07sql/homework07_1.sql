--create the view
drop view empview;

create view empview as
select e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, d.department_name
from employees e, departments d
where d.department_id = e.department_id;

--7.1.a
select first_name, last_name, employee_id from empview where rownum = 1 order by hire_date desc;

--7.1.b
update empview set department_name = 'Bean Counting' where department_name = 'Accounting';
--This does not work, I get the following error:

--ERROR at line 1:
--ORA-01779: cannot modify a column which maps to a non key-preserved table
--This is an error that we get because it cannot update the physical department table,
--because the department key is not in this view.

--7.1.c
 update empview set first_name = 'Jose' where first_name = 'Jose Manuel';
 
 --7.1.d
 insert into empview values (1, 'Mitch', 'Stark', 'fake', '28-Mar-2017', 'Bean Counting');
 --This did not work, I got the following error:
 --ERROR at line 1:
 --ORA-01776: cannot modify more than one base table through a join view
 --This is because there are two tables containing attributes in this view
 --and the insertion is unable to update the corresponding physical tables as well.