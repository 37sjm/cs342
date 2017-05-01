--1.2
--The DUAL table has a single column 'DUMMY' defined as VARCHAR2(1).
--This is useful if you are looking to compute something, because as a
--from statement is required, you can just use from dual in the expression

--to view this table, I used 
select * from dual; 
describe dual;
select 2 + 2 from dual;
