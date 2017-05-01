--6.2.a
select avg(trunc(months_between(sysdate, p.birthdate)/12)) from Person p;

--I believe that the "group" for this avg function is just the "group" of all
--records in the person table, which is why we simply get the average age of
--all people in the database.


--6.2.b
select h.id, count(householdId)
 from Household h, (select householdId from Person) 
 where h.id = householdId
 and h.city = 'Grand Rapids' 
 group by h.id
 having count(householdId) > 1
 order by count(householdId) desc;
 
 --6.2.c
 select h.id, count(householdId), h.phonenumber
 from Household h, (select householdId from Person) 
 where h.id = householdId
 and h.city = 'Grand Rapids' 
 group by h.id, h.phonenumber
 having count(householdId) > 1
 order by count(householdId) desc;