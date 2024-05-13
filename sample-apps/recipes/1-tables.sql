create sequence rec_tags_seq;

create table rec_tags (
	tag_id         number default on null rec_tags_seq.nextval not null,
	tag_name       varchar2(100 char) not null,
	tag_updated_at date default sysdate not null,
	constraint rec_tags_pk primary key ( tag_id ),
	constraint rec_tags_uk unique ( tag_name )
);

create sequence rec_ingredients_seq;

create table rec_ingredients (
	ing_id         number default on null rec_ingredients_seq.nextval not null,
	ing_name       varchar2(100 char) not null,
	ing_unit       varchar2(100 char) not null,
	ing_updated_at date default sysdate not null,
	constraint rec_ingredients_pk primary key ( ing_id ),
	constraint rec_ingredients_uk unique ( ing_name )
);

create sequence rec_recipes_seq;

create table rec_recipes (
	rec_id          number default on null rec_recipes_seq.nextval not null,
	rec_name        varchar2(100 char) not null,
	rec_tag_id      number,
	rec_description varchar2(1000 char) not null,
	rec_updated_at  date default sysdate not null,
	constraint rec_recipes_pk primary key ( rec_id ),
	constraint rec_recipes_uk unique ( rec_name ),
	constraint rec_recipes_tag_fk foreign key ( rec_tag_id )
		references rec_tags ( tag_id )
);

create sequence rec_recipe_ingredients_seq;

create table rec_recipe_ingredients (
	rng_id         number default on null rec_recipe_ingredients_seq.nextval not null,
	rng_rec_id     number not null,
	rng_ing_id     number not null,
	rng_amount     number not null,
	rng_updated_at date default sysdate not null,
	constraint rec_recipe_ingredients_pk primary key ( rng_id ),
	constraint rec_recipe_ingredients_uk unique ( rng_rec_id,
	                                              rng_ing_id ),
	constraint rec_recipe_ingredients_rec_fk foreign key ( rng_rec_id )
		references rec_recipes ( rec_id ),
	constraint rec_recipe_ingredients_ing_fk foreign key ( rng_ing_id )
		references rec_ingredients ( ing_id )
);

create sequence rec_shopping_list_seq;

create table rec_shopping_list (
	shl_id         number default on null rec_shopping_list_seq.nextval not null,
	shl_ing_id     number not null,
	shl_amount     number not null,
	shl_ticked     number default 0 not null,
	shl_updated_at date default sysdate not null,
	constraint rec_shopping_list_pk primary key ( shl_id ),
	constraint rec_shopping_list_ing_fk foreign key ( shl_ing_id )
		references rec_ingredients ( ing_id ),
	constraint rec_tiecked_ck check ( shl_ticked in ( 0,1 ) )
);
