-- alter 1.0.3  updated 3/5/2017  nrg
-- designating foreign keys and defining relationships

-- log in to psql using jackalope_test or jackalope with your user
-- \i /users/nickgramstad/documents/jackalope/alters/alter_1.0.3.sql
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
            ,'3'
            ,'designating foreign keys and defining relationships'
            ,now()
          );

alter table product add foreign key (publisher_id) references publisher(id);

alter table product_category add foreign key (product_division_id) references product_division(id);

alter table product_subcategory add foreign key (product_category_id) references product_category(id);

alter table product_category_label add foreign key (product_subcategory_id) references product_subcategory(id);

alter table product_category_label add foreign key (product_category_id) references product_category(id);

alter table product_category_label_link add foreign key (product_category_label_id) references product_category_label_link(id);

alter table inventory add foreign key (product_id) references product(id);

alter table inventory add foreign key (condition_id) references condition(id);

alter table product_mtg_card add foreign key (set_id) references product_mtg_set(id);

alter table product_mtg_card add foreign key (artist_id) references product_mtg_artist(id);

alter table product_mtg_gatherer_pricing add foreign key (product_mtg_card_id) references product_mtg_card(id);

alter table product_mtg_foreign_card add foreign key (country_id) references product_mtg_country(id);

alter table product_mtg_legality add foreign key (product_mtg_card_id) references product_mtg_card(id);

alter table product_mtg_card add foreign key (rarity_id) references product_mtg_rarity(id);

alter table product_mtg_card add foreign key (card_type_id) references product_mtg_card_type(id);

alter table product_mtg_card add foreign key (back_id) references product_mtg_card_back(id);

alter table ncards add primary key (nid);

alter table product_mtg_card add foreign key (gatherer_extractor_id) references ncards(nid);

alter table product add foreign key (product_subcategory_id) references product_subcategory(id);

commit;
