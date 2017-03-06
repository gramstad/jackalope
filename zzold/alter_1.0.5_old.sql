-- alter_1.0.5 02/26/2017 NRG
-- populating product category tables for M:TG and getting set data in prep for generating the product info for single cards
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
  ,5
  ,'populating product category tables for M:TG and getting set data in prep for generating the product info for single cards'
  ,now()
);

insert into product_subcategory (
  subcategory_name
  ,subcategory_code
  ,product_category_id
)
values (
'In Print M:TG Singles'
,'IP-MTG-S'
,(select id from product_category where product_category.category_code = 'MTG')
);

insert into product_subcategory (
  subcategory_name
  ,subcategory_code
  ,product_category_id
)
values (
'Out of Pr M:TG Singles'
,'OOP-MTG-S'
,(select id from product_category where product_category.category_code = 'MTG')
);

insert into product_category_label (
  category_label
  ,category_label_code
  ,product_subcategory_id
)
values (
  'Bulk'
  ,'OOP-MTG-BLK'
  ,(select id from product_subcategory where product_subcategory.subcategory_code = 'OOP-MTG-S')
);

insert into product_category_label (
  category_label
  ,category_label_code
  ,product_subcategory_id
)
values (
  'x4 Card Playset'
  ,'OOP-MTG-X4P'
  ,(select id from product_subcategory where product_subcategory.subcategory_code = 'OOP-MTG-S')
);

-- cleaning up product_mtg_set table in prep for population
alter table product_mtg_sets rename to product_mtg_set;

alter table product_mtg_set rename column cycle_name to cycle_block_id;

alter table product_mtg_set alter column cycle_block_id type integer using cycle_block_id::integer;

create table product_mtg_cycle_block (
  id serial primary key
  ,cycle_block_name varchar
);

create table product_mtg_set_type (
  id serial primary key
  ,set_type varchar
);

insert into product_mtg_set_type (
  set_type
)
values (
  'Core'
);

insert into product_mtg_set_type (
    set_type
  )
  values (
    'Expansion'
  );

alter table product_mtg_set add foreign key (cycle_block_id) references product_mtg_cycle_block(id);
-- this value is coming from the gather extractor; not sure what it does but keeping the values
alter table product_mtg_set add column code_magic_card varchar;

alter table product_mtg_set add column common_count int;

alter table product_mtg_set add column set_type int references product_mtg_set_type(id);

insert into product_mtg_set (
    set_name
    ,set_code
    ,code_magic_card
)
select
  nname
  ,ncode
  ,ncode_magiccards
from nsets
;

commit;
