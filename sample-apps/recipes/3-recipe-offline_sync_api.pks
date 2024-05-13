create or replace package recipe_offline_sync_api as

  procedure sync_ingredients_v1 (
    pi_json                 in json_object_t
  , pi_change_type          in varchar2
  , pi_change_date          in date
  , pi_updated_by           in varchar2
  , po_success              out nocopy boolean
  , po_sync_fail_reason     out nocopy offline_data_sync.sync_fail_reason%type
  , po_sync_device_pk       out nocopy offline_data_sync.sync_device_pk%type
  , po_snyc_db_pk           out nocopy offline_data_sync.sync_db_pk%type
  );

  procedure sync_recipes_v1 (
    pi_json                 in json_object_t
  , pi_change_type          in varchar2
  , pi_change_date          in date
  , pi_updated_by           in varchar2
  , po_success              out nocopy boolean
  , po_sync_fail_reason     out nocopy offline_data_sync.sync_fail_reason%type
  , po_sync_device_pk       out nocopy offline_data_sync.sync_device_pk%type
  , po_snyc_db_pk           out nocopy offline_data_sync.sync_db_pk%type
  );

  procedure sync_recipe_ingredients_v1 (
    pi_json                 in json_object_t
  , pi_change_type          in varchar2
  , pi_change_date          in date
  , pi_updated_by           in varchar2
  , po_success              out nocopy boolean
  , po_sync_fail_reason     out nocopy offline_data_sync.sync_fail_reason%type
  , po_sync_device_pk       out nocopy offline_data_sync.sync_device_pk%type
  , po_snyc_db_pk           out nocopy offline_data_sync.sync_db_pk%type
  );


end recipe_offline_sync_api;
/
