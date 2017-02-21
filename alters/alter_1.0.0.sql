-- Alter 1.0.0  2/19/17 Nick Gramstad
-- Creates database, creates user nick

-- Normally would have language here to make sure that all alters are applied but since this is the first file it is not neccessary.
DROP DATABASE if exists "jackalope";

CREATE DATABASE jackalope
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

  create user nick with
    PASSWORD '1888$celtic'
    CREATEDB;
