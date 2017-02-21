-- Alter 1.0.2 2/20/2017 NRG
-- Uploading set amd card data into staging tables to create product tables
create table mtg_core_set (
    set_name varchar,
    set_type varchar,
    set_symbol varchar,
    set_code varchar,
    pre_release_date timestamp,
    release_date timestamp,
    total_count int,
    common_count int,
    uncommon_count int,
    rare_count int,
    mythic_count int,
    basic_land_count int,
    other_count int
	);
 create table expansion_set_data (
     set_name varchar,
     expansion_symbol varchar,
     exp_code varchar,
     codename varchar,
     pre_release_date timestamp,
     release_date timestamp,
     total_count int,
     common_count int,
     uncommon_count int,
     rare_count int,
     mythic_count int,
     basic_land_count int,
     other_count int,
     block_name varchar,
     cycle_name varchar
     );
 -- uploads data for core sets into a staging table to be sliced and diced
 \copy mtg_core_set from '/users/nickgramstad/documents/jackalope/data_files/core_set_data.csv' with delimiter ',' CSV header;
 -- uploads data for expansion sets into a staging table to be sliced and diced
 \copy mtg_core_set from '/users/nickgramstad/documents/jackalope/data_files/expansion_set_data.csv' with delimiter ',' CSV header;
 -- uploads individual card data to be sliced and diced
