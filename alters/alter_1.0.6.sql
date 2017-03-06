-- alter 1.0.6  updated 03/05/2017  nrg
-- populating product_mtg_card

-- log in to psql using jackalope_test or jackalope with your user
-- \i /users/nickgramstad/documents/jackalope/alters/alter_1.0.6.sql
-- not all of these fields will be fully normalized and will need attention later
-- 31566 cards as of 03/05/2017
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

rollback;
commit;
