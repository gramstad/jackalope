-- alter 1.0.5  updated 03/05/2017  nrg
-- adding full alter number field to schema_change

-- log in to psql using jackalope_test or jackalope with your user
-- \i /users/nickgramstad/documents/jackalope/alters/alter_1.0.5.sql
begin;
alter table schema_change add column alter_name varchar;

update schema_change
  set alter_name = '1.0.0'
where schema_change.id = 1;

update schema_change
  set alter_name = '1.0.1'
where schema_change.id = 2;

update schema_change
  set alter_name = '1.0.2'
where schema_change.id = 3;

update schema_change
  set alter_name = '1.0.3'
where schema_change.id = 15;

update schema_change
  set alter_name = '1.0.4'
where schema_change.id = 17;

insert into schema_change
        (
            alter_name,
            major_release,
            minor_release,
            point_release,
            script_name,
            date_applied
        )
    values
          (
            '1.0.5'
            ,'1'
            ,'0'
            ,'5'
            ,'adding full alter number field to schema_change'
            ,now()
          );

commit;
