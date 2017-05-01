
 --create view
 create materialized view mat_birthday_czar for update as
 select firstname || ' ' || lastname as Name, birthdate, trunc(months_between(sysdate, birthdate)/12)
 from person;
 
--7.2.a
 select * from mat_birthday_czar
where extract(year from birthdate) > 1960
and extract(year from birthdate) < 1976;

--7.2.b
update person
set birthdate = '01-Jan-1965'
where birthdate is null;

--Error here, because this view is not updateable. When trying to use the for update syntax to make this view updateable,
-- I get the following error:
--ORA-12013: updatable materialized view must be simple enough and have a 
--materialized view log on its master table to do fast refresh

--7.2.c
insert into birthday_czar values ('mitch stark', '06-Jun-96', 20);

--Again, an error because this view is not updateable.

--7.2.d
 drop materialized view mat_birthday_czar;
 
 --No changes are made to the person table;