/*
[_obj] call player_packTent;
*/
if (dayz_actionInProgress) exitWith {localize "str_player_actionslimit" call dayz_rollingMessages;};
dayz_actionInProgress = true;

private ["_alreadyPacking","_backpacks","_bag","_campItems","_dir","_holder","_magazines","_obj","_objectID","_objectUID","_ownerID","_packobj","_playerNear","_pos","_weapons","_finished"];

_obj = _this;
_ownerID = _obj getVariable["CharacterID","0"];
_objectID = _obj getVariable["ObjectID","0"];
_objectUID = _obj getVariable["ObjectUID","0"];
if (DZE_permanentPlot) then {
	_ownerID = _obj getVariable["ownerPUID","0"];
};

// Make sure no other players are nearby
_playerNear = {isPlayer _x} count (([_obj] call FNC_GetPos) nearEntities ["CAManBase",10]) > 1;
if (_playerNear) exitWith {dayz_actionInProgress = false; localize "str_pickup_limit_5" call dayz_rollingMessages;};

_packobj = getText (configFile >> "CfgVehicles" >> typeOf _obj >> "pack");

player removeAction s_player_packtent;
s_player_packtent = -1;
player removeAction s_player_packtentinfected;
s_player_packtentinfected = -1;

_campItems = ["IC_DomeTent","IC_Tent"];

if (_ownerID in [dayz_characterID,dayz_playerUID] or typeOf _obj in _campItems) then {
	_alreadyPacking = _obj getVariable["packing",0];
	if (_alreadyPacking == 1) exitWith {localize "str_player_beingpacked" call dayz_rollingMessages;};

	_obj setVariable["packing",1,true];
	_dir = direction _obj;
	_pos = getPosATL _obj;

	[player,"tentpack",0,false,20] call dayz_zombieSpeak;
	[player,20,true,getPosATL player] call player_alertZombies;

	_finished = ["Medic",1] call fn_loopAction;
	if (isNull _obj) exitWith {};
	if (!_finished) exitWith {_obj setVariable["packing",0,true];};

	//place tent (local)
	_bag = createVehicle [_packobj, _pos, [], 0, "CAN_COLLIDE"];
	_bag setDir _dir;
	player reveal _bag;

	_holder = createVehicle ["WeaponHolder", _pos, [], 0, "CAN_COLLIDE"];

	_weapons = getWeaponCargo _obj;
	_magazines = getMagazineCargo _obj;
	_backpacks = getBackpackCargo _obj;

	PVDZ_obj_Destroy = [_objectID,_objectUID,player,_pos,dayz_authKey,false];
	publicVariableServer "PVDZ_obj_Destroy";
	PVDZ_obj_Destroy call server_deleteObj;
	deleteVehicle _obj;

	[_weapons,_magazines,_backpacks,_holder] call fn_addCargo;

	localize "str_success_tent_pack" call dayz_rollingMessages;
} else {
	localize "str_fail_tent_pack" call dayz_rollingMessages;
};
dayz_actionInProgress = false;
