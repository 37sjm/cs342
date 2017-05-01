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
  unlimited tablespace,
  IMP_FULL_DATABASE, 
  EXP_FULL_DATABASE 
  to mjs73;

DROP DIRECTORY exp_dir;
CREATE DIRECTORY exp_dir AS  'C:\app\sys1\product\12.1.0\dbhome_1\BIN\project\large\';
GRANT READ, WRITE ON DIRECTORY exp_dir to mjs73;