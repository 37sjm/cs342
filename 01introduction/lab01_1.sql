---a
 select * from departments;

---b
 select count(employee_id) from employees;

---c
---i
 select * from employees where salary >= 15000

---ii
 select * from employees where hire_date > TO_DATE('January 01, 2002', 'MONTH DD, YYYY') AND hire_date < TO_DATE('January 01, 2004', 'MONTH DD, YYYY');

---iii
 select * from employees where phone_number not like '%515%';

---d
 select first_name || ' ' || last_name as name from employees where department_id = 100 order by first_name;

---e
 select city, state_province, country_name from locations, countries where locations.country_id = countries.country_id and countries.region_id = 3;

---f
 select * from locations where state_province is null;
