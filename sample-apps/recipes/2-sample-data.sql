-- tags
insert into rec_tags (
	tag_id,
	tag_name,
	tag_updated_by
) values (
	1,
	'Baking',
	'oracle'
);

insert into rec_tags (
	tag_id,
	tag_name,
	tag_updated_by
) values (
	2,
	'Fryning',
	'oracle'
);

insert into rec_tags (
	tag_id,
	tag_name,
	tag_updated_by
) values (
	3,
	'Soup',
	'oracle'
);

select rec_tags_seq.nextval
  from dual
connect by
	level <= 10;

-- ingredients
insert into rec_ingredients (
	ing_id,
	ing_name,
	ing_unit,
	ing_updated_by
) values (
	1,
	'Pumpkin',
	'kg',
	'oracle'
);

insert into rec_ingredients (
	ing_id,
	ing_name,
	ing_unit,
	ing_updated_by
) values (
	2,
	'Chilli Flakes',
	'tsp',
	'oracle'
);

insert into rec_ingredients (
	ing_id,
	ing_name,
	ing_unit,
	ing_updated_by
) values (
	3,
	'Carrot',
	'pcs',
	'oracle'
);

insert into rec_ingredients (
	ing_id,
	ing_name,
	ing_unit,
	ing_updated_by
) values (
	4,
	'Onion',
	'pcs',
	'oracle'
);

insert into rec_ingredients (
	ing_id,
	ing_name,
	ing_unit,
	ing_updated_by
) values (
	5,
	'Olive Oil',
	'tsp',
	'oracle'
);

insert into rec_ingredients (
	ing_id,
	ing_name,
	ing_unit,
	ing_updated_by
) values (
	6,
	'Vegetable Stock',
	'ml',
	'oracle'
);

select rec_ingredients_seq.nextval
  from dual
connect by
	level <= 10;

-- recipes
insert into rec_recipes (
	rec_id,
	rec_name,
	rec_description,
	rec_updated_by
) values (
	1,
	'Pumpkin Soup',
	'Pumpkin soup is a usually "creamy" soup made from pumpkin. It is a popular Thanksgiving dish in the United States and is also eaten in Australia, the United Kingdom, and other parts of the world. It can be prepared with common ingredients such as salt, pepper, and nutmeg. It is a generally sweet soup, despite also being used in savory dishes and is a traditional flavor of fall and winter. It is often served with croutons or a dollop of sour cream.'
	,
	'oracle'
);

select rec_recipes_seq.nextval
  from dual
connect by
	level <= 10;

-- rec_recipe_ingredients

insert into rec_recipe_ingredients (
	rng_rec_id,
	rng_ing_id,
	rng_amount,
	rng_updated_by
) values (
	1,
	1,
	0.5,
	'oracle'
);

insert into rec_recipe_ingredients (
	rng_rec_id,
	rng_ing_id,
	rng_amount,
	rng_updated_by
) values (
	1,
	2,
	1,
	'oracle'
);

insert into rec_recipe_ingredients (
	rng_rec_id,
	rng_ing_id,
	rng_amount,
	rng_updated_by
) values (
	1,
	3,
	2,
	'oracle'
);

insert into rec_recipe_ingredients (
	rng_rec_id,
	rng_ing_id,
	rng_amount,
	rng_updated_by
) values (
	1,
	4,
	1.5,
	'oracle'
);

insert into rec_recipe_ingredients (
	rng_rec_id,
	rng_ing_id,
	rng_amount,
	rng_updated_by
) values (
	1,
	5,
	1,
	'oracle'
);

insert into rec_recipe_ingredients (
	rng_rec_id,
	rng_ing_id,
	rng_amount,
	rng_updated_by
) values (
	1,
	6,
	500,
	'oracle'
);

select rec_recipe_ingredients_seq.nextval
  from dual
connect by
	level <= 10;


commit;
