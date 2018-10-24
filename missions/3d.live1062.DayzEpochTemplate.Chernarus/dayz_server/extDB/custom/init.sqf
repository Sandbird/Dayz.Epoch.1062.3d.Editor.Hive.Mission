private ["_return","_result","_options","_extDB_SQL_CUSTOM_ID"];

_return = false;
//"extDB3" callExtension "9:RESET";
//extDB_SQL_CUSTOM_ID = nil;

if ( isNil {uiNamespace getVariable "extDB_SQL_CUSTOM_ID"}) then
{
	// extDB3 Version Check
	_result = "extDB3" callExtension "9:VERSION";
	"extDB3" callExtension "9:RESET";
	if (_result == "") then
	{
	  diag_log "extDB3 Failed to Load, Check Requirements @ https://bitbucket.org/torndeco/extdb3/wiki/Installation";
	  diag_log "";
	  diag_log "If you are running this on a client, Battleye will random block extensions. Try Disable Battleye";
	  extDB3_var_loaded = false;
	  if (_result == "") exitWith {diag_log "extDB3: Failed to Load Extension"; false};
	} else {
	  diag_log "extDB3 Loaded";
	  extDB3_var_loaded = true;
	  diag_log format ["extDB3: Version: %1", _result];
	};

	if ((parseNumber _result) < 1.026) exitWith {diag_log "Error: extDB3 version 1.026 or Higher Required";};
	// extDB3 Connect to Database
	//if(!extDB3_var_loaded) then {
		_result = call compile ("extDB3" callExtension format["9:ADD_DATABASE:%1", DB_NAME]);
		if (_result select 0 == 0) exitWith {diag_log format ["extDB3: Error Failed to Connect to Database: %1", _result]; false};
		diag_log "extDB3: Connected to Database";
	//};

	// Generate Randomized Protocol Name
	_random_number = round(random(999999));
	_extDB_SQL_CUSTOM_ID = str(_random_number);
	//_extDB_SQL_CUSTOM_ID = call compile _extDB_SQL_CUSTOM_ID;

	
	// Possible Options
	//TEXT = Wraps Text Datatypes (not VARCHAR) with "<insert result>"
	//TEXT2 = Wraps Text Datatypes (not VARCHAR) with '<insert result>'
	//NULL = Convert NULL Value to objNull, otherwise it is "" by default.
	// examples
	//   private _options = "TEXT";
	//   private _options = "TEXT-NULL";
	//   private _options = "TEXT2";
	//   private _options = "TEXT2-NULL";
	
	_options = "TEXT";
	/*
	0 = Sync  
	1 = ASync (Doesnt save/return results, use for updating DB Values)  
	2 = ASync + Save (Returns ID, for use with 5)
	4 = Get (Retrieve Single Part Message)
	5 = Get (Retrieves Multi-Msg Message)
	9 = System Commands
	*/
	//diag_log format ["9:ADD_DATABASE_PROTOCOL:%1:SQL:%2:%3", DB_NAME, _extDB_SQL_CUSTOM_ID, _options];
	//_result = call compile ("extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:AltisLife:SQL_CUSTOM:%1:altis-life-custom.ini",(call life_sql_id)]);
	_result = call compile ("extDB3" callExtension format["9:ADD_DATABASE_PROTOCOL:%1:SQL:%2:%3", DB_NAME, _extDB_SQL_CUSTOM_ID, _options]);
	if ((_result select 0) == 0) exitWith {diag_log format ["9:ADD_DATABASE_PROTOCOL:%1:SQL:%2:%3", DB_NAME, _extDB_SQL_CUSTOM_ID, _options]; false};

	diag_log("extDB3: Initalized SQL_CUSTOM Protocol");
 	uiNamespace setVariable ["extDB_SQL_CUSTOM_ID", _extDB_SQL_CUSTOM_ID];
 
	// extDB3 Lock
	//"extDB3" callExtension "9:LOCK";
	//diag_log("extDB3: Locked");
	
	_return = true;
}
else
{
	diag_log("extDB3: Already Setup");
	_return = true;
};

_return