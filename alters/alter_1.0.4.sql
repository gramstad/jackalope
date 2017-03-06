-- alter 1.0.4  updated 03/05/2017  nrg
-- populating the product category tables for M:TG

-- log in to psql using jackalope_test or jackalope with your user
-- \i /users/nickgramstad/documents/jackalope/alters/alter_1.0.4.sql
begin;
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
            ,'4'
            ,'populating the product category tables for M:TG'
            ,now()
          );

insert into publisher (
  publisher_name
  ,publisher_code
)
values (
  'Wizards of the Coast'
  ,'WOTC'
);

insert into product_division (
  division_name
  ,division_code
)
values (
'Trading Card Games'
,'TCG'
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

insert into product_subcategory (
  subcategory_name
  ,subcategory_code
  ,product_category_id
)
values (
'M:TG Singles'
,'MTGSNGL'
,(select id from product_category where product_category.category_code = 'MTG')
);

insert into product_subcategory (
  subcategory_name
  ,subcategory_code
  ,product_category_id
)
values (
'M:TG x4 Playset'
,'MTGX4PSET'
,(select id from product_category where product_category.category_code = 'MTG')
);

insert into product_subcategory (
  subcategory_name
  ,subcategory_code
  ,product_category_id
)
values (
'M:TG Full Common/Uncommon Playset'
,'MTGFULLCUNSET'
,(select id from product_category where product_category.category_code = 'MTG')
);

insert into product_subcategory (
  subcategory_name
  ,subcategory_code
  ,product_category_id
)
values (
'M:TG Bulk Common/Uncommon'
,'MTGBLKCUN'
,(select id from product_category where product_category.category_code = 'MTG')
);

commit;
