---a
--i
insert into movie values (1, 'dontcare', 2000, 2.2);

--ii
insert into movie values (null, 'dontcare', 2000, 2.2);

--iii
insert into movie values (1, 'dontcare', 1232, 2.2);

--iv
insert into movie values (1.9, 'new', 2000, 8.9);

--v
insert into movie values (6, 'newmovie', 1997, -1);

---b
--i
insert into casting values (1, null, 'star');

--ii
insert into casting values (200, 2, 'star');

--iii
insert into movie values (8, 'Mitch', 2000, 10);


---c
--i
delete from movie where id=1;

--ii
delete from casting where movieid=2;

--iii
update movie set id=1 where id=2;
