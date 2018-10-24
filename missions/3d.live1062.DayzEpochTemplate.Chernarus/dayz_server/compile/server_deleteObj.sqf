/*
[_objectID,_objectUID,_activatingPlayer,_objPos,dayz_authKey] call server_deleteObj;
For PV calls from the client use this function, otherwise if calling directly from the server use server_deleteObjDirect
*/
private["_id","_uid","_key","_activatingPlayer","_objPos","_clientKey","_exitReason","_PlayerUID","_processDelete"];

if (count _this < 5) exitWith {diag_log "Server_DeleteObj error: Improper parameter format";};
_id 	= _this select 0;
_uid 	= _this select 1;
_activatingPlayer 	= _this select 2;
_objPos = _this select 3; //Can be object or position if _processDelete is false
_clientKey = _this select 4;
_processDelete = if (count _this > 5) then {_this select 5} else {true};
_PlayerUID = _activatingPlayer getVariable ["playerUID", 0];

_exitReason = [_this,"DeleteObj",_objPos,_clientKey,_PlayerUID,_activatingPlayer] call server_verifySender;
if (_exitReason != "") exitWith {diag_log _exitReason};

if (isServer) then {
	if (_processDelete) then {deleteVehicle _objPos};
	//remove from database
	if (parseNumber _id > 0) then {
		//Send request
		//_key = format["CHILD:304:%1:",_id];
		_key = format["DELETE FROM Object_DATA WHERE `ObjectID` = '%1'",_id];
		_key call server_hiveWrite;
		diag_log format["DELETE: Player %1(%2) deleted object with ID: %3",(_activatingPlayer call fa_plr2str), _PlayerUID, _id];
	} else  {
		//Send request
		//_key = format["CHILD:310:%1:",_uid];
		_key = format["DELETE FROM Object_DATA WHERE `ObjectUID` = '%1'",_uid];
		_key call server_hiveWrite;
		diag_log format["DELETE: Player %1(%2) deleted object with UID: %3",(_activatingPlayer call fa_plr2str), _PlayerUID, _uid];
	};
};