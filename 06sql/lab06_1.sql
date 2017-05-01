--lab 6.1
select t.name, t.mandate, p.personid
from Team t left outer join PersonTeam p
on t.name = p.teamname
and p.role = 'chair';