-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden, extended by: Mitch Stark


--4.2.a BCNF -> PersonTeam non-trivial functional dependencies = none (two people with the same name can be on different teams
--																		and a single person can be on many teams)
--				PersonVisit non-trivial functional dependencies = none (two people with the same name can have different visiting dates
--																		and a single person can visit many times)
--		4NF -> PersonTeam multivalued dependencies are all trivial (the superkey is personName, teamName which means that the left hand side will always be a super key)
--				Same for the PersonVist table.
-- These tables are technically in both BCNF and 4NF.


--4.2.b The view created in the query is in BCNF. The only functional dependency personName, teamName, personVisit -> personName, teamName, personVisit is trivial.
-- However, this view is not 4NF. Given a teamName and a personName, there are still many possible personVisit data to generate, meaning this table is not 4NF.

--4.2.c No, the schema are not equally appropriate, it depends on what exactly the purpose of the database is for.
--			If the purpose is to map every person to their (possibly many) teams, as well as map every person to their visits, then
--			the two tables would be more apppropriate. However, if you want to grab the person name, team name, and their visits all at once,
--			then having a single table containing all of the required infromation would be more appropriate, although I feel that neither optioned
--			is designed particularly well.
DROP TABLE PersonTeam;
DROP TABLE PersonVisit;
drop table queryview;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
create table queryview (
	personName varchar(10),
	personTeam varchar(10),
	personVisit varchar(10),
	primary key (personName, personteam, personvisit)
	);


insert into queryview SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;