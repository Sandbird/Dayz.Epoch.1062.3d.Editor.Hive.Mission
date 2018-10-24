private ["_uid","_queryResult","_row","_value","_dbcheck","_protocolCheck","_result"];
//Simple test script to get player's Bankmoney from the database, add 1 to it and then update again

_uid = player getVariable ["playerUID", 0];
_result = "extDB3" callExtension "9:VERSION";
//diag_log format ["extDB3: Version: %1", _result];
if(_result == "") exitWith {systemChat "extDB3: Failed to Load"; false};
/*
_result = call compile ("extDB3" callExtension format["9:ADD_DATABASE:dayz_cherno"]);
if (_result select 0 == 0) exitWith {systemChat format ["extDB3: Error Database: %1", _result]; false};
systemChat "extDB3: Connected to Database";


_dbcheck = "extDB3" callExtension "9:ADD_DATABASE:dayz_cherno";
*/
_protocolCheck = "extDB3" callExtension "9:ADD_DATABASE_PROTOCOL:dayz_cherno:SQL:OurExampleSQLProtocol2:TEXT";
/*
0 = Sync  
1 = ASync (Doesnt save/return results, use for updating DB Values)  
2 = ASync + Save (Returns ID, for use with 5)
4 = Get (Retrieve Single Part Message)
5 = Get (Retrieves Multi-Msg Message)
9 = System Commands
*/
_queryResult =  call compile ("extDB3" callExtension format["0:OurExampleSQLProtocol2:SELECT * From player_data WHERE PlayerUID=%1",_uid]); //extensions can only return string, so we have to compile the string to a result array code and call that
//NOTE: queryResult will have the following form: [ResultCode,[row1,row2,...,rowN]]
_resultArray = call compile format ["%1",_queryResult];
_row = ((_resultArray select 1 select 0) select 6); // select first row from result
_value = _row + 1;
_queryResult =  call compile ("extDB3" callExtension format["0:OurExampleSQLProtocol2:UPDATE player_data SET BankCoins=%1 WHERE PlayerUID=%2",_value,_uid]);
systemChat format ["extDB3: Live update: %1", _row];

player addMagazine "SMAW_HEDP";
player addMagazine "SMAW_HEDP";
player addMagazine "SMAW_HEDP";
