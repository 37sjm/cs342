--Query 1
select * from 
movie m inner join moviedirector md on m.id = md.movieid 
inner join director d on md.directorid = d.id and d.firstname = 'Clint' and d.lastname = 'Eastwood';

--Query 2
select directorid, count(*) from moviedirector md group by md.directorid having count(*) > 200;

--Query 3
select a.id, avg(m.rank) from 
actor a inner join role r on a.id = r.actorid 
inner join movie m on m.id = r.movieid 
group by a.id 
having count(*) > 10;

--Query Analysis:
--For each of these queries I could have implemented them with a full join, 
--then narrowed down by where clauses. However, it is much faster to join on certain 
--conditions so that we don't join entire tables needlessly. I attempted to use the execution
--plan to help me decide when to join tables, and what would be most efficient. I did not use
--indeces because in my understanding of it, Oracle already has indeces for the primary keys of tables
--which was what I was joining on so it did not seem like that would optimize my queries (the execution
--time of the first query was the same with or without indeces.)