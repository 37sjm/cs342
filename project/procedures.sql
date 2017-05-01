create or replace procedure moveTeam(teamToFind in integer, fromLeagueId in integer, toLeagueId in integer, newStanding in integer) as 
	teamsFound integer;
begin
	select count(*) into teamsFound from league_standing where teamId = teamToFind and leagueId = fromLeagueId;

	if teamsFound = 1 then
		delete from league_standing where teamId = teamToFind and fromLeagueId = leagueId;
		insert into league_standing values (teamToFind, toLeagueId, newStanding);
		dbms_output.put_line('Succesfully moved.');
	else
		dbms_output.put_line('Did not succesfully find a single team with that id.');
	end if;
end;
/
SHOW ERRORS;