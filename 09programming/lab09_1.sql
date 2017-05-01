--9.1.a

explain plan for select count(*) from movie;
@explain;

explain plan for select count(1) from movie;
@explain;

explain plan for select sum(1) from movie;
@explain;


--All of the above queries seem to have the same efficiency. 
-- They all have the same time, cpu usage, and plan, making it seem that there is no difference between the queries.

--9.1.b
explain plan for select * from movie, director;
@explain;
--times:
--09.39
--07.33
--07.21

explain plan for select * from director, movie;
@explain;
--times:
--25.45
--33.29
--23.91

--These two queries definitely vary in efficiency. Honestly, I'm unsure as to why there is such a difference. The plans explained for these
--two queries are the exact same. However, when I actually run the above queries, one is much faster than the other. The plans
--show that in each case the director table is selected from first, and then joins with the Movie so it does not seem like there is a difference
--because of the order that the tables are joined.


--9.1.c
explain plan for select * from Movie join MovieDirector on Movie.id = MovieDirector.movieid;
@explain;

explain plan for select * from Movie join MovieDirector on Movie.id + 1 = MovieDirector.movieid + 1;
@explain;
--There does not seem to be a difference in efficiency if a query has arithmetic involved with the join on condition.
--These two queries had identical plans, cpu usage, and times.


--9.1.d
explain plan for select * from role;
@explain;
--Time: 
--1st run: 4.50
--2nd run: 5.02
--3rd run: 3.84
--4th run: 0.98
--5th run: 4.67
--6th run: 2.59
--These runs were on average faster as they went on; however, because of the spike in the 5th run I'm unsure of whether or not these "faster" times can be attributed
--to Oracle becoming smarter about running the queries, or simply luck.

--9.1.e
select * from actor, director where actor.firstname = director.firstname;
--time: 09:37

create index name on Actor(firstname);


select * from actor, director where actor.firstname = director.firstname;
--time: 07:96


--This was slightly faster with the name being indexed, I'm assuming it's because Oracle had much quicker access to each row by firstname.