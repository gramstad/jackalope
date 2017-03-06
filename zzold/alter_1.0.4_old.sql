-- alter_1.0.4 02/26/2017 NRG
-- populating product tables with M:TG information
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
  ,4
  ,'populating product tables with M:TG information'
  ,now()
);

insert into product_division (
  division_name
  ,division_code
)
values (
'Trading Card Games'
,'TCG'
);

insert into publisher (
  publisher_name
  ,publisher_code
)
values (
'Wizards of the Coast'
,'WOTC'
);

insert into product_category (
  category_name
  ,category_code
  ,product_division_id
)
values (
'Magic: The Gathering'
,'MTG'
,(select id from product_division where product_division.division_code = 'TCG')
);

commit;
