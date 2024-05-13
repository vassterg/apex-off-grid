create or replace package body offline_data_sync_api as

  --gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  c_unix_epoch date := to_date('1970-01-01', 'YYYY-MM-DD');

  function get_change_date (
		pi_json in json_object_t
	) return date
	as
	begin
		return c_unix_epoch + NUMTODSINTERVAL( (pi_json.get_number('__change_ts') / 1000), 'SECOND' );
	end get_change_date;

	function get_change_type (
		pi_json in json_object_t
	) return varchar2
	as
	begin
		return pi_json.get_string('__change_type');
	end get_change_type;

	procedure remove_json_metadata (
		pi_json in out json_object_t
	)
	as
	begin
		pi_json.remove('__change_ts');
		pi_json.remove('__change_type');
	end remove_json_metadata;

	function num_to_date (
		pi_number in number
	) return date
	as
		l_date date;
	begin
		l_date := c_unix_epoch + NUMTODSINTERVAL( (pi_number / 1000), 'SECOND' );
		apex_debug.info( apex_string.format('num_to_date - Input: %0, output: %1', pi_number, to_char(l_date, 'YYYY-MM-DD HH24:MI:SS')) );
		return l_date;
	end num_to_date;

  procedure sync_row (
    pi_json_str             in offline_data_sync.sync_data_json%type
  , pi_sync_storage_id      in offline_data_sync.sync_storage_id%type
  , pi_sync_storage_version in offline_data_sync.sync_storage_version%type
  , po_success              out nocopy boolean
  , po_sync_fail_reason     out nocopy offline_data_sync.sync_fail_reason%type
  , po_sync_device_pk       out nocopy offline_data_sync.sync_device_pk%type
  , po_snyc_db_pk           out nocopy offline_data_sync.sync_db_pk%type
  )
  as
    l_json				json_object_t;
		l_change_type varchar2(1);
		l_change_date date;
  begin
    po_success := false;
		l_json := json_object_t.parse(pi_json_str);
		l_change_date := get_change_date(l_json);
		l_change_type := get_change_type(l_json);
		remove_json_metadata(l_json);

		apex_debug.info( apex_string.format('Processing %0 v%1...', pi_sync_storage_id, pi_sync_storage_version) );
		apex_debug.info( apex_string.format('Change Type: %0', l_change_type) );
		apex_debug.info( apex_string.format('Change Date: %0', to_char(l_change_date, 'YYYY-MM-DD HH24:MI:SS')) );
		apex_debug.info( apex_string.format('Data: %0', l_json.stringify) );


    -- sample implementation for recipes sample app
    -- implement your own storage handlers here

    /*
    case 
			when pi_sync_storage_id = 'ingredients' and pi_sync_storage_version = 1 then

				recipe_offline_sync_api.sync_ingredients_v1 (
					pi_json                 => l_json
				, pi_change_type          => l_change_type
				, pi_change_date          => l_change_date
				, pi_updated_by           => v('APP_USER')
				, po_success              => po_success
				, po_sync_fail_reason     => po_sync_fail_reason
				, po_sync_device_pk       => po_sync_device_pk
				, po_snyc_db_pk           => po_snyc_db_pk
				);

			when pi_sync_storage_id = 'recipes' and pi_sync_storage_version = 1 then

				recipe_offline_sync_api.sync_recipes_v1 (
					pi_json                 => l_json
				, pi_change_type          => l_change_type
				, pi_change_date          => l_change_date
				, pi_updated_by           => v('APP_USER')
				, po_success              => po_success
				, po_sync_fail_reason     => po_sync_fail_reason
				, po_sync_device_pk       => po_sync_device_pk
				, po_snyc_db_pk           => po_snyc_db_pk
				);

			when pi_sync_storage_id = 'recipe_ingredients' and pi_sync_storage_version = 1 then

				recipe_offline_sync_api.sync_recipe_ingredients_v1 (
					pi_json                 => l_json
				, pi_change_type          => l_change_type
				, pi_change_date          => l_change_date
				, pi_updated_by           => v('APP_USER')
				, po_success              => po_success
				, po_sync_fail_reason     => po_sync_fail_reason
				, po_sync_device_pk       => po_sync_device_pk
				, po_snyc_db_pk           => po_snyc_db_pk
				);

    else
      po_sync_fail_reason := apex_string.format('Unhandled storage: %0 v%1', pi_sync_storage_id, pi_sync_storage_version);
      return;
    end case;
  */

  exception
    when others then
      -- do not raise, just insert snyc as failed
      po_sync_fail_reason := sqlerrm || ' | ' || dbms_utility.format_error_backtrace;
  end sync_row;

end offline_data_sync_api;
/
