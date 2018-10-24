private ["_veh","_location","_isOk","_vehtospawn","_dir","_pos","_helipad","_keyColor","_keyNumber","_keySelected","_isKeyOK","_config","_player"];
_vehtospawn = _this select 0; // Vehicle string
_player = player;
_dir = getdir vehicle _player;
_pos = getPos vehicle _player;
_pos = [(_pos select 0)+8*sin(_dir),(_pos select 1)+8*cos(_dir),0];
 
// First select key color
_keyColor = ["Green","Red","Blue","Yellow","Black"] call BIS_fnc_selectRandom;
 
// then select number from 1 - 2500
_keyNumber = (floor(random 2500)) + 1;
 
// Combine to key (eg.ItemKeyYellow2494) classname
_keySelected = format[("ItemKey%1%2"),_keyColor,_keyNumber]; 
_isKeyOK =  isClass(configFile >> "CfgWeapons" >> _keySelected); 
_config = _keySelected;
_isOk = [_player,_config] call BIS_fnc_invAdd;

waitUntil {!isNil "_isOk"};

if (_isOk and _isKeyOK) then {
 
	_dir = round(random 360); 
	_location = _pos;
	if(count _location != 0) then {
		//place vehicle spawn marker (local)
		PVDZE_veh_Publish2 = [[_dir,_location],_vehtospawn,false,_keySelected,_player,dayz_authKey];
		publicVariableServer  "PVDZE_veh_Publish2";
		PVDZE_veh_Publish2 call server_publishVeh2;
		
		"Vehicle spawned, key added to toolbelt." call dayz_rollingMessages;

		// Tool use logger
		if(EAT_logMajorTool) then {
			EAT_PVEH_usageLogger = format["%1 %2 -- has added a permanent vehicle: %3",name _player,(_player getVariable["playerUID", 0]),_vehtospawn];
			publicVariableServer "EAT_PVEH_usageLogger";
		};
	} else {
		_removeitem = [_player, _config] call BIS_fnc_invRemove;
		"Could not find an area to spawn vehicle." call dayz_rollingMessages;
	};
} else {
	"Your toolbelt is full." call dayz_rollingMessages;
};
