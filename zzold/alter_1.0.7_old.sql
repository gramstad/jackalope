-- alter 1.0.7 02/26/2017 NRG
-- populating fields in m:tg product tables
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
  ,7
  ,'populating fields in m:tg product tables'
  ,now()
);

select product_mtg_set.id as "set_id", ncards.nset as "ncards_set", product_mtg_card.id as "mtg_productid"
into product_mtg_product_id_setup
from product_mtg_card
	inner join ncards
    	on product_mtg_card.gatherer_extractor_id = ncards.nid
	inner join product_mtg_set
    	on ncards.nset = product_mtg_set.set_code;

-- need to change the number from text to int in ncards so I can move the value to product_mtg_card.gatherer_extractor_id
alter table product_mtg_card alter column product_mtg_card.card_number type varchar using card_number::varchar;

-- inserting the product_mtg_set.id into product_mtg_card
insert into product_mtg_card (
  set_id
)
values (
  (select set_id
    from product_mtg_product_id_setup
      inner join product_mtg_card
        on product_mtg_product_id_setup.mtg_productid = product_mtg_card.gatherer_extractor_id)
);





-- product_code are going to be used as internal SKUs; for singles this will be combo of set code, card number and product category code
select
  (product_mtg_card.set_id + product_mtg_card.card_number + 'MTG') as "product_code"
  ,product_mtg_card.gatherer_extractor_id as "gatherer_id"
    into staging_mtg_card_product
from product_mtg_card;

insert into product (
  publisher_id
  ,product_code
)
values (
  '1' -- Publisher WOTC for M:TG
  ,(select staging_mtg_card_product.product_code from staging_mtg_card_product)
);

-- product_id code added to mtg_product table(s) to link the main product ids to the support info
-- need to create the column in the support table(s)
alter table product_mtg_card add column product_id int references product(id);
-- creating a link from product to staging_mtg_card_product; will pop. this field and then sling in to product_mtg_card to ensure data integrity
alter table staging_mtg_card_product add column product_id int;

-- populating staging_mtg_card_product.product_id
insert into staging_mtg_card_product (
  staging_mtg_card_product.product_id
)
values (
  (select product.id
    from product
      inner join staging_mtg_card_product
        on product.product_code = staging_mtg_card_product.product_code)
);
-- populating product_mtg_card.product_id
insert into product_mtg_card (
  product_mtg_card.product_id
)
values (
  (select staging_mtg_card_product.product_id
    from staging_mtg_card_product
      inner join product_mtg_card
        on staging_mtg_card_product.gatherer_id = product_mtg_card.gatherer_extractor_id)
);
rollback;
commit;
