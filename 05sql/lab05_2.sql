--5.2.a.
--ROWNUM
--not correlated
select *
from (select * from person where birthdate is not null order by birthdate desc)
where rownum = 1;

--not correlated
--could not think of a way except for using max.
select *
from Person P
where birthdate = (select max(birthdate) from person);
--Both of the queries above return a single row of the youngest person in the database.

--5.2.b
select p1.id, p1.firstname || ' ' || p1.lastname as p1_fullname, p2.id, p2.firstname || ' ' || p2.lastname as p2_fullname
from Person p1, Person p2
where p1.firstname = p2.firstname and p1.id <> p2.id and p1.id > p2.id;
--if there is three are three people with the same name, then there are
--three different rows selected. I believe the number of rows selected for
--n people would be (n - 1)^2

--5.2.c
--sub select
--Not correlated
select firstname || ' ' || lastname
 from Person
 where homegroupid <> (select id from homegroup where name = 'Byl') 
 and id in (select personid from personteam where teamname = 'Music');
 
--set operations
(select firstname || ' ' || lastname
 from Person, PersonTeam
 where person.id = personteam.personid
 and personteam.teamname = 'Music')
minus
(select firstname || ' ' || lastname
  from Person, Homegroup
  where person.homegroupid = homegroup.id and homegroup.name = 'Byl');