-- Creates table to track alters. Should help when needing to reconstruct the database. Code taken from http://odetocode.com/blogs/scott/archive/2008/01/31/versioning-databases-the-baseline.aspx
create table schema_change (
    id serial unique not null,
    major_release varchar(2) not null,
    minor_release varchar(2) not null,
    point_release varchar(4) not null,
    script_name varchar(140) not null,
    date_applied timestamp not null,

    constraint pk_schema_change
      primary key (id)
);

-- Populates the table with information from alter_1.0.0 and alter_1.0.1 insert into schema_change
insert into schema_change
(
    major_release,
    minor_release,
    point_release,
    script_name,
    date_applied
)
values
  (
    '1'
    ,'0'
    ,'0'
    ,'database and user creation'
    ,now()
  );

insert into schema_change
(
    major_release,
    minor_release,
    point_release,
    script_name,
    date_applied
) 
values
    (
      '1'
      ,'0'
      ,'1'
      ,'create alter tracking'
      ,now()
    );