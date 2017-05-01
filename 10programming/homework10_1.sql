create or replace procedure transferRank(fromMovie in integer, toMovie in integer, rankTransfer in float) AS
moviesFound INTEGER;
previousFromRank FLOAT;
previousToRank FLOAT;
movieNotFoundException EXCEPTION;
tooLowException EXCEPTION;
BEGIN
	LOCK TABLE movie
	IN EXCLUSIVE MODE;
	
	
	select count(*) into moviesFound from movie where id = fromMovie OR id = toMovie;
	
	if moviesFound != 2 then
		raise movieNotFoundException;
	end if;
	
	
	select rank into previousFromRank from movie where id = fromMovie;
	select rank into previousToRank from movie where id = toMovie;
	
	if (previousFromRank - rankTransfer < 0) then
		raise tooLowException;
	end if;
	
	
	update movie set rank = previousFromRank - rankTransfer where id = fromMovie;
	update movie set rank = previousToRank + rankTransfer where id = toMovie;
	
	commit;
	
EXCEPTION
	when movieNotFoundException then
		RAISE_APPLICATION_ERROR(-20001, 'One of the movies entered was not found'); rollback;
		
	when tooLowException then
		RAISE_APPLICATION_ERROR(-20002, 'Rank cannot go below 0'); rollback;
	
END;

/
SHOW ERRORS;

create or replace procedure test as
BEGIN
	FOR i IN 1..10000 LOOP
		transferRank(176712, 176711, 0.1);
		COMMIT;
		transferRank(176711, 176712, 0.1);
		COMMIT;
	END LOOP;
END;
/
SHOW ERRORS;