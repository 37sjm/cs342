drop table RankLog;

create table RankLog (
	id integer primary key,
	username varchar(30),
	changeDate date,
	originalid integer,
	originalname varchar(100),
	originalyear integer,
	originalrank number(10,2),
	originalsequelId integer,
	new_id integer,
	newname varchar(100),
	newyear integer,
	newrank number(10,2),
	newsequelId integer
);

create or replace trigger logUpdates before update on Movie for each row
declare
newranklog_id integer;
begin
	BEGIN
	select max(id) into newranklog_id from ranklog group by id;
	EXCEPTION
	when NO_DATA_FOUND then
	newranklog_id := 0;
	end;

	insert into ranklog values (newranklog_id, USER, sysdate, :old.id, :old.name, :old.year, :old.rank, :old.sequelId, :new.id, :new.name, :new.year, :new.rank, :new.sequelId);
END;
/
SHOW ERRORS;

