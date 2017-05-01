-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team IDs are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden, extended by: Mitch Stark

--4.1.a Informal - This is not a well designed table. We can easily see this when looking seeing that a person
--					can be on many teams. Since there is only one table, we will either have to re-enter all
--					of the information in a tuple, with a different team, or create a list as a string which
--					would break first normal form.
--		Formal - We can see straight away that there is a lot of redundant information in the table.
--					mentorId -> mentorName, mentorStatus which means that we should only be storing
--					the mentorId, as the rest will be redundant data after the first entry. Similarly,
--					there is an overuse of null because for every person that does not yet have a mentor,
--					there will be 3 null values instead of just setting the mentorId to null.
--4.1.b -- BCNF - FAIL - There is a functional dependency that shows that mentorId -> mentorName, and mentorStatus. However,
--					mentorId on its own is not a superkey, which means we are not in BCNF.

--			3NF - (if we assume that the candidate key is personId, mentorId, and include a teamName) - PASS - When given
--				a personId, their mentorId, and teamName, we can determine all of the other rows in the table. Even if
--				a person is on multiple teams, we will be able to determine the rest of the data given those three values.


--Homework 4 - 1.c
drop table PersonTeam;
drop table Person;
drop table Team cascade constraints;

create table Person (
	id integer primary key,
	name varchar(10),
	status char(1),
	mentorId integer,
	foreign key (mentorId) references Person(id) on delete set null
	);
	
create table Team (
	name varchar(10) primary key,
	teamTime varchar(10)
	);
	
create table PersonTeam (
	person_id integer,
	team_name varchar(10),
	role varchar(10),
	primary key (person_id, team_name),
	foreign key (person_id) references Person(id) on delete cascade,
	foreign key (team_name) references Team(name) on delete cascade
	);


-- drop table AltPerson;

-- --CREATE TABLE AltPerson (
	-- --personId integer,
	-- name varchar(10),
	-- status char(1),
	-- mentorId integer,
	-- mentorName varchar(10),
	-- mentorStatus char(1),
    -- teamName varchar(10),
    -- teamRole varchar(10),
    -- teamTime varchar(10)
	-- );

-- INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
insert into person values (1, 'Shamkant', 'm', null);
insert into person values (0, 'Ramez', 'v', 1);
insert into Team values ('elders', 'Monday');
insert into personteam values (0, 'elders', 'trainee');
-- INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
insert into personteam values (1, 'elders', 'chair');
-- INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
insert into team values ('executive', 'Wednesday');
insert into personteam values (1, 'executive', 'protem');
-- INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
insert into person values (3, 'Jeff', 'm', null);
insert into person values (2, 'Jennifer', 'v', 3);
insert into team values ('deacons', 'Tuesday');
insert into personteam values (2, 'deacons', 'treasurer');
-- INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');
insert into personteam values (3, 'deacons', 'chair');


--Queries:
select * from person;
select * from team;
select * from personteam;
