--This query returns the total goals that each team has scored so far this season.
--As a stakeholder (web app developer), I would use this data as a heuristic to help me
--predict which team's are more likely to score more goals, and therfore, win their games.
select team.name as name, sum(player.goals) as Total_Goals
from player, team
where player.teamid = team.id
and player.gs is not null
group by team.name;
--It might be possible to use a sub-select for each of the goals scored for each team, and then sum those up (I
--didn't actually try this, but I believe that it would be possible). However, I chose to do it this way
--because it utilizes the built-in functions of oracle to sum up attributes and group them as I want, and
--this looks much simpler than a sub-select query.

--This query returns every player in the database, along with the team name, league name, and league location when applicable.
--This is useful to stakeholders for getting a list of all the players and their associated teams, along with free agents
--if they exist in the database (discovered because of the left outer join)
select p.name as Player_Name, t.name as Team_Name, le.name as League_Name, le.location as League_Location from 
player p left outer join team t
on p.teamid = t.id
inner join league_standing l
on l.teamid = t.id
inner join league le
on le.id = l.leagueid;
--This query could be written with all different sorts of joins. However, I chose to write this query the way I did so that
--all players in the database would be returned, and it would also return the leagues/teams of each player that is a part of one.


--This query returns a list of two players who combine for over 35 contributed goals. This is an important heuristic for 
--stakeholders because teams with these "dynamic duos" are more likely to win than team's without those teams.
select p1.name, p2.name, t.name
from player p1, player p2, team t
where (p1.goals + p1.assists + p2.goals + p2.assists) > 35
and p1.teamid = p2.teamid
and p1.num > p2.num
and p1.teamid = t.id;
--I cannot think of another way of writing this query (at least not another way that would be reasonable).


--This query returns a list of team names that have more than 1 player with over 15 goals. Again, this is an important heuristic 
--because this is another piece of data that can be used to help predict games and who will win.
select t.name from 
	(select p.teamid from player p
	where p.goals > 15), team t
where teamid = t.id
having count(teamid) > 1
group by t.name;
--This query could have been written by selecting the count of all the teams in the sub-query (and thus not requiring a sub-select). However,
--I chose to write this query in a sub-select fashion because it can now be easily modified to contain other information, like the total number of goals from each player
--or other data similar. The more data and heuristics that I can get, the better each match prediction will be.


--This view is a subset of players that are commonly starting for their teams. I would use this view to create more accurate heuristics for predictions
--because this view provides data on players that are much more likely to actually be involved in each game.
create view Common_Starters as
select * from player where player.gs > 10;
--I chose to not use a materialized view because as players data get updated in the physical players table, common starters may change, and this view
--needs to reflect that.