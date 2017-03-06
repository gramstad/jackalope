-- alter 1.0.6 02/26/2017 NRG
-- creating product records and product support records for M:TG singles
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
  ,6
  ,'creating product records and product support records for M:TG singles'
  ,now()
);

-- converting gatherer_id to integer; required field for getting rest of data in
alter table product_mtg_card alter column gatherer_extractor_id type varchar using gatherer_extractor_id::varchar;

-- not all of these fields will be fully normalized and will need attention later
-- 31566 cards as of 2/26/2017
insert into product_mtg_card (
  card_name
  ,gatherer_extractor_id
  ,mana_cost
  ,ability
  ,flavor_text
  ,ruling
  ,color
  ,generated_mana
  ,back_id
  ,watermark
  ,print_number
  ,color_identity
)
select
  nname
  ,nid
  ,nmanacost
  ,nability
  ,nflavor
  ,nruling
  ,ncolor
  ,ngenerated_mana
  ,nback_id
  ,nwatermark
  ,nprint_number
  ,ncolor_identity
  from ncards;
commit;
