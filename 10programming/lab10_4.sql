CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		LOCK TABLE movie
		IN EXCLUSIVE MODE;
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/
SHOW ERRORS;


--The original procedure did not work with mutliple simultaneous runs, because it was running into a race condition.
--The above procedure (modified) now works.