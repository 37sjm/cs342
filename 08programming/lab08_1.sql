CREATE OR REPLACE PROCEDURE castActor(actorId IN INTEGER, movieId IN INTEGER, roleType in Role.role%type) AS
actorFound integer;
movieFound integer;
BEGIN
	select id into actorFound from actor where id = actorId;
	if actorFound is null then
		dbms_output.put_line('Actor Not Found');
	else
		dbms_output.put_line('Actor Found');
		select id into movieFound from movie where id = movieId;
		if movieFound is null then
			dbms_output.put_line('Movie Not Found');
		else
			dbms_output.put_line('Movie Found');
			insert into role values (actorId, movieId, roleType);
		end if;
	end if;
END;
/
SHOW ERRORS;

CREATE OR REPLACE TRIGGER roleTrig BEFORE INSERT ON Role FOR EACH row
DECLARE
actorcounter INTEGER;
castcounter integer;
castTooBig EXCEPTION;
actorAlreadyInserted EXCEPTION;
BEGIN
	select count(*) into actorcounter from role where actorId = :new.actorid and movieid = :new.movieid;
	select count(*) into castcounter from role where movieId = :new.movieid;
	
	if actorcounter <> 0 then
		dbms_output.put_line('Cannot insert the same actor twice.');
		raise actorAlreadyInserted;
	end if;
	
	if castcounter > 229 then
		dbms_output.put_line('Cast is full');
		raise castTooBig;
	end if;
EXCEPTION
	when castTooBig then
		RAISE_APPLICATION_ERROR(-20001, 'full cast:' || :new.movieid);
		
	when actorAlreadyInserted then
		RAISE_APPLICATION_ERROR(-20002, 'Actor already inserted:' || :new.actorId);
END;
/
SHOW ERRORS;


call castActor(89558, 238072, 'Danny Ocean');

call castActor(89558, 238073, 'Danny Ocean');

call castActor(89558, 167324, 'Danny Ocean');