-- Alter 1.0.3 02/26/2017 NRG
-- creating basic product tables and support tables for M:TG products

-- Didn't run update for 1.0.2 in the schema_change table
begin;
insert into schema_change (
  major_release
  ,minor_release
  ,point_release
  ,script_name
  ,date_applied
)
values (
  1
  ,0
  ,2
  ,'uploading set amd card data into staging tables to create product tables'
  ,now()
);

insert into schema_change (
  major_release
  ,minor_release
  ,point_release
  ,script_name
  ,date_applied
)
values (
  1
  ,0
  ,3
  ,'creating basic product tables and support tables for M:TG products'
  ,now()
);

-- each product will belong to a division, category, sub category and labels
-- ie comics -> oop comic -> oop back issue -> golden age
-- product can have multiple labels but only one division/category/subcategory
create table product_division (
  id serial primary key
  ,division_name varchar
  ,division_code varchar
  ,division_description varchar
);

create table publisher (
  id serial primary key
  ,publisher_name varchar
  ,publisher_code varchar
);

create table product_category (
  id serial primary key
  ,category_name varchar
  ,category_code varchar
  ,category_description varchar
  ,product_division_id int references product_division(id)
);

create table product_subcategory (
  id serial primary key
  ,subcategory_name varchar
  ,subcategory_code varchar
  ,subcategory_description varchar
  ,product_category_id int references product_category(id)
);

-- labels will allow for flexibility below the subcategory level for reporting and organization
create table product_category_label (
  id serial primary key
  ,category_label varchar
  ,category_label_code varchar
  ,category_description varchar
  ,product_subcategory_id int references product_subcategory(id)
);

create table product (
  id serial primary key
  ,product_code varchar
  ,publisher_id int references publisher(id)
);

-- linking table that will allow a product to be associated with multiple labels and/or groups of labels
create table product_category_code (
  id serial primary key
  ,product_id int references product(id)
  ,product_category_label_id int references product_category_label(id)
);

create table product_mtg_sets (
  id serial primary key
  ,set_name varchar
  ,set_code varchar
  ,codename varchar
  ,pre_release_date timestamp
  ,release_date timestamp
  ,total_card_count int
  ,uncommon_count int
  ,rare_count int
  ,mythic_count int
  ,basic_land_count int
  ,other_card_count int
  ,block_name varchar
  ,cycle_name varchar
);

create table product_mtg_artist (
  id serial primary key
  ,first_name varchar
  ,last_name varchar
);

create table product_mtg_card (
  id serial primary key
  ,card_name varchar
  ,set_id int references product_mtg_sets(id)
  ,card_type_id int
  ,rarity_id int
  ,mana_cost varchar
  ,converted_manacost int
  ,"power" int
  ,toughness int
  ,loyalty int
  ,ability text
  ,flavor_text text
  ,variation int
  ,artist_id int references product_mtg_artist(id)
  ,card_number int
  ,rating int
  ,ruling text
  ,color varchar
  ,generated_mana varchar
  ,back_id varchar
  ,watermark text
  ,print_number varchar
  ,is_original boolean
  ,color_identity varchar
  ,gatherer_extractor_id int
);

create table pricing_mtg_gatherer_extractor_card (
  id serial primary key
  ,product_mtg_card_id int references product_mtg_card(id)
  ,gatherer_pricing_low decimal(11,2)
  ,gatherer_pricing_mid decimal(11,2)
  ,gatherer_pricing_high decimal(11,2)
  ,last_update timestamp
);

-- Table that holds country codes for foreign card tables. cn = China, etc
create table mtg_foreign_country (
  id serial primary key
  ,country_code varchar
  ,country_name varchar
);

create table product_mtg_card_foreign (
  id serial primary key
  ,product_mtg_card_id int references product_mtg_card(id)
  ,country_id int references mtg_foreign_country(id)
  ,card_name varchar
  ,type varchar
  ,ability text
  ,flavor_text text
);

create table legality_mtg_card (
  id serial primary key
  ,product_mtg_card_id int references product_mtg_card(id)
  ,block boolean
  ,standard boolean
  ,modern boolean
  ,legacy boolean
  ,vintage boolean
  ,highlander boolean
  ,french_commander boolean
  ,tiny_leaders_commander boolean
  ,leviathan_command boolean
  ,commander boolean
  ,peasant boolean
  ,pauper boolean
);

-- table stores a type code used to ID what the condition code is used for. There will be one for comics, another for M:TG, etc.
create table product_condition_type (
  id serial primary key
  ,condition_type_code varchar
  ,condition_type_description varchar
  ,product_division_id int references product_division(id)
);

create table product_condition_code (
  id serial primary key
  ,product_condition_code_name varchar
  ,product_condition_code varchar
  ,product_condition_type_id int references product_condition_type(id)
);

commit;
