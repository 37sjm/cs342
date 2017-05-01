alter table player
add check (age > 0);

alter table league_standings
add check (standing >= 1 and standing <= 20);
