create or replace trigger leagueStandingTrigger before insert on league_standing for each row
declare
teamsInLeague integer;
leagueTooBig exception;
begin
	select count(*) into teamsInLeague from league_standing where leagueid = :new.leagueid;
	if teamsInLeague > 19 then
		raise leagueTooBig;
	end if;

exception
	when leagueTooBig then
		RAISE_APPLICATION_ERROR(-20001, 'full league:' || :new.leagueid);
end;
/
show errors;