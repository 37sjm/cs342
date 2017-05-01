--5.1.a
select *
from Person, Household;
--128 columns selected because there are 8 columns in Household and
--16 columns in Person and 16 * 8 = 128

--5.1.b
--returns 10 records ordered by the birthday's day of the year
select *
from person
where birthdate is not null
order by TO_CHAR(birthdate, 'DDD');
