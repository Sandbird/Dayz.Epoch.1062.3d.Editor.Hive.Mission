/*
	File: asyncCall.sqf
	Author: Bryan "Tonic" Boardwine

	Description:
	Commits an asynchronous call to extDB
	Gets result via extDB  4:x + uses 5:x if message is Multi-Part
	
	 [_data,2] call extDB_async; //get results
	 [_data,1] call extDB_async; //just update
	 [_data,2,2] call extDB_async; //get results and add it inside []

	Parameters:
		0: INTEGER (1 = ASYNC + not return for update/insert, 2 = ASYNC + return for query's).
		1: STRING (Query to be ran).
*/
private["_keyformat","_queryStmt","_queryResult","_key","_mode","_return","_loop","_extDB_SQL_CUSTOM_ID"];

/*
if (!params [
	["_mode", 0, [0]],
	["_queryStmt", "", [""]]
]) exitWith {};
*/

_queryStmt = [_this,0,"",[""]] call BIS_fnc_param;
_mode = [_this,1,1,[0]] call BIS_fnc_param;  //was: _mode = [_this,1,1,[0]] call BIS_fnc_param;
_multiarr = [_this,2,false,[false]] call BIS_fnc_param;

//["0:OurExampleSQLProtocol2:SELECT * From player_data WHERE PlayerUID=%1",_uid]
_extDB_SQL_CUSTOM_ID = uiNamespace getVariable "extDB_SQL_CUSTOM_ID";
_extDB_SQL_CUSTOM_ID = call compile _extDB_SQL_CUSTOM_ID;
//diag_log(_extDB_SQL_CUSTOM_ID);
_keyformat = format["%1:%2:%3",_mode, _extDB_SQL_CUSTOM_ID, _queryStmt];
_key = "extDB3" callExtension _keyformat;
if(_mode == 1) exitWith {true};

_key = call compile format["%1",_key];
_key = _key select 1;

uisleep (random .03);

_queryResult = "";
_loop = true;
while{_loop} do
{
	_queryResult = "extDB3" callExtension format["4:%1", _key];
	if (_queryResult == "[5]") then {
		// extDB3 returned that result is Multi-Part Message
		_queryResult = "";
		while{true} do {
			_pipe = "extDB3" callExtension format["5:%1", _key];
			if(_pipe == "") exitWith {_loop = false};
				_return = _queryResult + _pipe;
		};
	}
	else
	{
		if (! (_queryResult == "[3]")) then { 
			_loop = false; 
		}; 
/*
		if (_queryResult == "[3]") then
		{
			diag_log format ["extDB3: uisleep [4]: %1", diag_tickTime];
			uisleep 0.1;
		} else {
			_loop = false;
		};
*/		
	};
};

//_queryResult = call compile _queryResult;
//diag_log format ["extDB3: _queryResult: %1", _queryResult];
// Not needed, its SQF Code incase extDB ever returns error message i.e Database Died
//if ((_queryResult select 0) == 0) exitWith {diag_log format ["extDB: Error: %1", _queryResult]; []};
//_queryResult = (_queryResult select 1);


if(!_multiarr) then {
	if (typeName _queryResult == "STRING") then {_return = _queryResult} else {_return = (_queryResult select 0)};
};

//if ((_queryResult select 0) == 0) exitWith {diag_log format ["extDB: Protocol Error: %1", _queryResult]; []};
//if(count (_queryResult select 1) == 0) exitWith {[]};
//_return = (_queryResult select 1);
//diag_log format ["extDB3: _queryResult2: %1", _return];


_return;