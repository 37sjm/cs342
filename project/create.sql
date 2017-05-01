drop user mjs73 cascade;

create user mjs73
identified by password
quota 5M on System;
grant
  connect,
  create table,
  create session,
  create sequence,
  create view,
  create materialized view,
  create procedure,
  create trigger,
  unlimited tablespace
  to mjs73;

connect mjs73/password;

--I've simply put all the files in the same directory as sqlplus
@load

