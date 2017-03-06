-- Alter 1.0.0  03/05/17 Nick Gramstad
-- create database and users

-- script will be run from psql on the main postgres database w/ user postgres
-- \i /users/nickgramstad/documents/jackalope/alters/alter_1.0.0.sql
drop database if exists "jackalope";

drop database if exists "jackalope_test";

create database jackalope_test
    with
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

create database jackalope
      with
      OWNER = postgres
      ENCODING = 'UTF8'
      LC_COLLATE = 'C'
      LC_CTYPE = 'C'
      TABLESPACE = pg_default
      CONNECTION LIMIT = -1;

drop user if exists nick;

create user nick with
        SUPERUSER
        PASSWORD '1888$celtic'
        CREATEDB;

commit;
