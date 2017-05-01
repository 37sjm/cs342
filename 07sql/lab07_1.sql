--create view
 create view birthday_czar as
 select firstname || ' ' || lastname as Name, birthdate, trunc(months_between(sysdate, birthdate)/12)
 from person;
 
--7.1.a
select * from birthday_czar
where extract(year from birthdate) > 1960
and extract(year from birthdate) < 1976;

--7.1.b
--update records
update person
set birthdate = '01-Jan-1965'
where birthdate is null;

select * from birthday_czar
where extract(year from birthdate) > 1960
and extract(year from birthdate) < 1976;

--This selects all the people in the person table that are GenX, including the newly updated people.


--7.1.c
insert into birthday_czar values ('mitch stark', '06-Jun-96', 20);
--this does not work. In order to insert a value into the view, the view must also contain the key
-- that is in the physical person table.


--7.1.d.
drop view birthday_czar;

--No changes were made to the physical person table. Removing the view did not affect any rows in the original table.