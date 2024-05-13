create or replace package body recipe_offline_sync_api as

  procedure sync_ingredients_v1 (
    pi_json                 in json_object_t
  , pi_change_type          in varchar2
  , pi_change_date          in date
  , pi_updated_by           in varchar2
  , po_success              out nocopy boolean
  , po_sync_fail_reason     out nocopy offline_data_sync.sync_fail_reason%type
  , po_sync_device_pk       out nocopy offline_data_sync.sync_device_pk%type
  , po_snyc_db_pk           out nocopy offline_data_sync.sync_db_pk%type
  )
  as
    l_row rec_ingredients%rowtype;
    l_orig_change_date date := offline_data_sync_api.num_to_date(pi_json.get_number('ING_UPDATED_AT'));
    l_db_change_date date;
  begin
		apex_debug.info( apex_string.format('sync_ingredients_v1... pi_change_type: %0 | data: %1', pi_change_type, pi_json.stringify) );

    l_row.ing_id := pi_json.get_number('ING_ID');
    l_row.ing_name := pi_json.get_string('ING_NAME');
    l_row.ing_unit := pi_json.get_string('ING_UNIT');
    l_row.ing_updated_at := pi_change_date;

    case pi_change_type
			when 'I' then
        po_sync_device_pk := l_row.ing_id;
        po_snyc_db_pk := rec_ingredients_seq.nextval;
        l_row.ing_id := po_snyc_db_pk;

				insert into rec_ingredients
				values l_row;

			when 'U' then
        po_snyc_db_pk := l_row.ing_id;

        select ing_updated_at
          into l_db_change_date
          from rec_ingredients
         where ing_id = l_row.ing_id;

        if l_orig_change_date != l_db_change_date then
          po_success := false;
          po_sync_fail_reason := 'ROW_OUTDATED';
          return;
        end if;

				update rec_ingredients
				   set row = l_row
			   where ing_id = l_row.ing_id;

			when 'D' then
        po_snyc_db_pk := l_row.ing_id;

				delete from rec_ingredients
				 where ing_id = l_row.ing_id;

		end case;

    po_success := true;

  exception
    when others then
      po_success := false;
      po_sync_fail_reason := sqlerrm || ' - ' || dbms_utility.format_error_backtrace;
  end sync_ingredients_v1;


  procedure sync_recipes_v1 (
    pi_json                 in json_object_t
  , pi_change_type          in varchar2
  , pi_change_date          in date
  , pi_updated_by           in varchar2
  , po_success              out nocopy boolean
  , po_sync_fail_reason     out nocopy offline_data_sync.sync_fail_reason%type
  , po_sync_device_pk       out nocopy offline_data_sync.sync_device_pk%type
  , po_snyc_db_pk           out nocopy offline_data_sync.sync_db_pk%type
  )
  as
    l_row rec_recipes%rowtype;
    l_orig_change_date date := offline_data_sync_api.num_to_date(pi_json.get_number('REC_UPDATED_AT'));
    l_db_change_date date;
  begin
		apex_debug.info( apex_string.format('sync_recipes_v1... pi_change_type: %0 | data: %1', pi_change_type, pi_json.stringify) );

    l_row.rec_id := pi_json.get_number('REC_ID');
    l_row.rec_name := pi_json.get_string('REC_NAME');
    l_row.rec_tag_id := pi_json.get_string('REC_TAG_ID');
    l_row.rec_description := pi_json.get_string('REC_DESCRIPTION');
    l_row.rec_updated_at := pi_change_date;

    case pi_change_type
			when 'I' then
        po_sync_device_pk := l_row.rec_id;
        po_snyc_db_pk := rec_recipes_seq.nextval;
        l_row.rec_id := po_snyc_db_pk;

				insert into rec_recipes
				values l_row;

			when 'U' then
        po_snyc_db_pk := l_row.rec_id;

        select rec_updated_at
          into l_db_change_date
          from rec_recipes
         where rec_id = l_row.rec_id;

        if l_orig_change_date != l_db_change_date then
          po_success := false;
          po_sync_fail_reason := 'ROW_OUTDATED';
          return;
        end if;

				update rec_recipes
				   set row = l_row
			   where rec_id = l_row.rec_id;

			when 'D' then
        po_snyc_db_pk := l_row.rec_id;

				delete from rec_recipes
				 where rec_id = l_row.rec_id;

		end case;

    po_success := true;

  exception
    when others then
      po_success := false;
      po_sync_fail_reason := sqlerrm || ' - ' || dbms_utility.format_error_backtrace;
  end sync_recipes_v1;

  function get_db_rec_id (
    pi_client_rec_id in varchar2
  ) return rec_recipes.rec_id%type
  as
    l_count  number;
    l_rec_id rec_recipes.rec_id%type;
  begin
    select count(*)
      into l_count
      from rec_recipes
     where rec_id = pi_client_rec_id;

    if l_count = 1 then
      return pi_client_rec_id;
    end if;

    select sync_db_pk
      into l_rec_id
      from offline_data_sync
     where sync_device_pk = pi_client_rec_id
       and sync_storage_id = 'recipes'
       and sync_storage_version = 1
    ;

    return l_rec_id;
  exception
    when no_data_found then
      return null;
  end get_db_rec_id;

  function get_db_ing_id (
    pi_client_ing_id in varchar2
  ) return rec_ingredients.ing_id%type
  as
    l_count  number;
    l_ing_id rec_ingredients.ing_id%type;
  begin
    select count(*)
      into l_count
      from rec_ingredients
     where ing_id = pi_client_ing_id;

    if l_count = 1 then
      return pi_client_ing_id;
    end if;

    select sync_db_pk
      into l_ing_id
      from offline_data_sync
     where sync_device_pk = pi_client_ing_id
       and sync_storage_id = 'ingredients'
       and sync_storage_version = 1
    ;

    return l_ing_id;
  exception
    when no_data_found then
      return null;
  end get_db_ing_id;


  procedure sync_recipe_ingredients_v1 (
    pi_json                 in json_object_t
  , pi_change_type          in varchar2
  , pi_change_date          in date
  , pi_updated_by           in varchar2
  , po_success              out nocopy boolean
  , po_sync_fail_reason     out nocopy offline_data_sync.sync_fail_reason%type
  , po_sync_device_pk       out nocopy offline_data_sync.sync_device_pk%type
  , po_snyc_db_pk           out nocopy offline_data_sync.sync_db_pk%type
  )
  as
    l_row rec_recipe_ingredients%rowtype;
    l_orig_change_date date := offline_data_sync_api.num_to_date(pi_json.get_number('RNG_UPDATED_AT'));
    l_db_change_date date;
  begin
		apex_debug.info( apex_string.format('sync_recipe_ingredients_v1... pi_change_type: %0 | data: %1', pi_change_type, pi_json.stringify) );

    l_row.rng_id := pi_json.get_number('RNG_ID');
    l_row.rng_amount := pi_json.get_string('RNG_AMOUNT');
    l_row.rng_updated_at := pi_change_date;

    l_row.rng_rec_id := get_db_rec_id (pi_json.get_string('RNG_REC_ID') );
    if l_row.rng_rec_id is null then
      po_success := false;
      po_sync_fail_reason := 'REC_ID_NOT_FOUND';
      return;
    end if;

    l_row.rng_ing_id := get_db_ing_id (pi_json.get_string('RNG_ING_ID') );
    if l_row.rng_ing_id is null then
      po_success := false;
      po_sync_fail_reason := 'ING_ID_NOT_FOUND';
      return;
    end if;

    case pi_change_type
			when 'I' then
        po_sync_device_pk := l_row.rng_id;
        po_snyc_db_pk := rec_recipe_ingredients_seq.nextval;
        l_row.rng_id := po_snyc_db_pk;

				insert into rec_recipe_ingredients
				values l_row;

			when 'U' then
        po_snyc_db_pk := l_row.rng_id;

        select rng_updated_at
          into l_db_change_date
          from rec_recipe_ingredients
         where rng_id = l_row.rng_id;

        if l_orig_change_date != l_db_change_date then
          po_success := false;
          po_sync_fail_reason := 'ROW_OUTDATED';
          return;
        end if;

				update rec_recipe_ingredients
				   set row = l_row
			   where rng_id = l_row.rng_id;

			when 'D' then
        po_snyc_db_pk := l_row.rng_id;

				delete from rec_recipe_ingredients
				 where rng_id = l_row.rng_id;

		end case;

    po_success := true;

  exception
    when others then
      po_success := false;
      po_sync_fail_reason := sqlerrm || ' - ' || dbms_utility.format_error_backtrace;
  end sync_recipe_ingredients_v1;



end recipe_offline_sync_api;
/
