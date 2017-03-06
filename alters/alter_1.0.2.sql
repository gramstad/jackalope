-- alter 1.0.2  updated 3/5/2017  nrg

-- import Gatherer Extractor data and create product tables
-- log in to psql using jackalope_test or jackalope with your user
-- \i /users/nickgramstad/documents/jackalope/data_files/gatherer_baseline.sql

-- log in to psql usring jackalope_test or jackalope
-- \i /users/nickgramstad/documents/jackalope/alters/alter_1.0.2.sql
begin;
-- creating product tables
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
            ,'2'
            ,'creating product tables'
            ,now()
          );

-- every item sold by the company will have a product record
-- the product code will be used as an internal scannable id
create table product (
  id serial primary key
  ,product_code varchar
  ,publisher_id int
  ,product_subcategory_id int
);

-- every item will have a publisher or manufacturer
create table publisher (
  id serial primary key
  ,publisher_name varchar
  ,publisher_code varchar
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

create table product_category (
  id serial primary key
  ,category_name varchar
  ,category_code varchar
  ,category_description varchar
  ,product_division_id int
);

create table product_subcategory (
  id serial primary key
  ,subcategory_name varchar
  ,subcategory_code varchar
  ,subcategory_description varchar
  ,product_category_id int
);

-- labels will allow for flexibility below the subcategory level for reporting and organization
-- populate either category_id or subcategory_id but not both
create table product_category_label (
  id serial primary key
  ,category_label varchar
  ,category_label_code varchar
  ,category_description varchar
  ,product_category_id int
  ,product_subcategory_id int
);

-- linking table that will allow a product to be associated with multiple labels and/or groups of labels
create table product_category_label_link (
  id serial primary key
  ,product_id int
  ,product_category_label_id int
);

/* inventory records are comibinations of products and the product condition. the condition can make a large difference in the price of an item.
*/
create table inventory (
  id serial primary key
  ,inventory_code varchar
  ,product_id int
  ,condition_id int
);

create table condition (
  id serial primary key
  ,product_category_id int
  ,condition_name varchar
  ,condition_code varchar
  ,condition_description text
);

-- most products will need customized data to support its sale
-- These tables support M:TG

-- product support table for individual M:TG cards
-- most fields from Gatherer Extractor
create table product_mtg_card (
  id serial primary key
  ,card_name varchar
  ,set_id int
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
  ,artist_id int
  ,card_number int
  ,rating int
  ,ruling text
  ,color varchar
  ,generated_mana varchar
  ,back_id int
  ,watermark text
  ,print_number varchar
  ,is_original boolean
  ,color_identity varchar
  ,gatherer_extractor_id varchar
);

-- each M:TG card belongs to a "set"
create table product_mtg_set (
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

create table product_mtg_gatherer_pricing (
  id serial primary key
  ,product_mtg_card_id int
  ,gatherer_pricing_low decimal(11,2)
  ,gatherer_pricing_mid decimal(11,2)
  ,gatherer_pricing_high decimal(11,2)
  ,last_update timestamp
);

-- Table that holds country codes for foreign card tables. cn = China, etc
create table product_mtg_country (
  id serial primary key
  ,country_code varchar
  ,country_name varchar
);

create table product_mtg_foreign_card (
  id serial primary key
  ,product_mtg_card_id int
  ,country_id int
  ,card_name varchar
  ,type varchar
  ,ability text
  ,flavor_text text
);

create table product_mtg_legality (
  id serial primary key
  ,product_mtg_card_id int
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

create table product_mtg_card_type (
  id serial primary key
  ,type_name varchar
);

create table product_mtg_rarity (
  id serial primary key
  ,rarity_name varchar
  ,rarity_code varchar
);

create table product_mtg_card_back (
  id serial primary key
  ,back_text varchar
);

commit;
