--5.3.a
select distinct hus.lastname || ', ' || hus.firstName || ' and ' || wif.firstname || ' - ' || H.phonenumber || ' - ' || H.street as Entry
from Household H, Person hus, Person wif
where H.id = hus.householdId
and H.id = wif.householdId
and hus.lastname = wif.lastname
and hus.householdrole = 'husband'
and wif.householdrole = 'wife';

--5.3.b
select distinct hus.lastname || ', ' || hus.firstName || ' and ' || wif.firstname || ' - ' || H.phonenumber || ' - ' || H.street
from Household H, Person hus, Person wif
where H.id = hus.householdId
and H.id = wif.householdId
and hus.lastname = wif.lastname
and hus.householdrole = 'husband'
and wif.householdrole = 'wife'
union
select distinct hus.lastname || ', ' || hus.firstName || ' and ' || wif.firstname || ' ' || wif.lastname || ' - ' || H.phonenumber || ' - ' || H.street
from Household H, Person hus, Person wif
where H.id = hus.householdId
and H.id = wif.householdId
and hus.lastname <> wif.lastname
and hus.householdrole = 'husband'
and wif.householdrole = 'wife';

--5.3.c
select distinct hus.lastname || ', ' || hus.firstName || ' and ' || wif.firstname || ' - ' || H.phonenumber || ' - ' || H.street
from Household H, Person hus, Person wif
where H.id = hus.householdId
and H.id = wif.householdId
and hus.lastname = wif.lastname
and hus.householdrole = 'husband'
and wif.householdrole = 'wife'
union
select distinct hus.lastname || ', ' || hus.firstName || ' and ' || wif.firstname || ' ' || wif.lastname || ' - ' || H.phonenumber || ' - ' || H.street
from Household H, Person hus, Person wif
where H.id = hus.householdId
and H.id = wif.householdId
and hus.lastname <> wif.lastname
and hus.householdrole = 'husband'
and wif.householdrole = 'wife'
union
select p.lastname || ', ' || p.firstName || ' - ' || h.phonenumber || ' - ' || h.street 
from Household H, Person p
where p.householdId = H.id
and p.householdrole = 'single';