drop table baconNumbers;

create table baconNumbers (
	actorId integer primary key,
	distance integer
);

--This takes a long time to run because the amount of actors to look through
create or replace procedure baconNumber(actorToFind in integer, depthnum in integer) AS
cursor associatedActors is
	select actorId from role where movieid in (select movieid from role where actorId = actorToFind);
actorFound integer;
previousDepth integer;
BEGIN
	--bacon id = 22591
	if depthnum = 1 then
		insert into baconNumbers values (actorToFind, 0);
	end if;
	
	if depthnum > 5 then
		return;
		
	end if;
	
	for actor in associatedActors loop
	
		select count(*) into actorFound from baconNumbers b where b.actorId = actor.actorId;
	
		if actorFound = 0 then
			insert into baconNumbers values (actor.actorId, depthnum);
			baconNumber(actor.actorid, depthnum + 1);
					
		else 
			select distance into previousDepth from baconNumbers b where b.actorId = actor.actorId;
			
			if depthnum < previousDepth then
					update baconNumbers b set b.distance = depthnum where b.actorId = actor.actorId;
					baconNumber(actor.actorId, depthnum + 1);
			end if;
			
		end if;
		--recur
	end loop;
END;
/
SHOW ERRORS;

call baconNumber(22591, 1);