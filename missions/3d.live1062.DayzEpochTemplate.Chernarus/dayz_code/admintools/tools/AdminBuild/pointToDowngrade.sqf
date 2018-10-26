private ["_location","_dir","_classname","_text","_object","_objectID","_objectUID","_newclassname","_obj","_downgrade","_objectCharacterID"];

player removeAction s_player_downgrade_build;
s_player_downgrade_build = 1;

// get cursor target
_obj = cursorTarget;
if(isNull _obj) exitWith {s_player_downgrade_build = -1; "No Object Selected" call dayz_rollingMessages};

_objectCharacterID 	= _obj getVariable ["CharacterID","0"];// Current charID
if (DZE_Lock_Door != _objectCharacterID) exitWith {s_player_downgrade_build = -1; localize "str_epoch_player_49" call dayz_rollingMessages;};
_objectID 	= _obj getVariable ["ObjectID","0"];// Find objectID
_objectUID	= _obj getVariable ["ObjectUID","0"];// Find objectUID

if(_objectID == "0" && _objectUID == "0") exitWith {s_player_downgrade_build = -1; cutText [(localize "str_epoch_player_50"), "PLAIN DOWN"];};

// Get classname
_classname = typeOf _obj;

// Find display name
_text = getText (configFile >> "CfgVehicles" >> _classname >> "displayName");

// Find next downgrade
_downgrade = getArray (configFile >> "CfgVehicles" >> _classname >> "downgradeBuilding");

if ((count _downgrade) > 0) then {

	_newclassname = _downgrade select 0;

	// Get position
	_location	= _obj getVariable["OEMPos",(getposATL _obj)];

	// Get direction
	_dir = getDir _obj;
	_vector = [(vectorDir _obj),(vectorUp _obj)];

	// Reset the character ID on locked doors before they inherit the newclassname
	if (_classname in DZE_DoorsLocked) then {
		_obj setVariable ["CharacterID",dayz_characterID,true];
		_objectCharacterID = dayz_characterID;
	};

	_classname = _newclassname;
	_object = createVehicle [_classname, [0,0,0], [], 0, "CAN_COLLIDE"]; 	// Create new object
	_object setDir _dir;			// Set direction
	_object setVariable["memDir",_dir,true];
	_object setVectorDirAndUp _vector;
	_object setPosATL _location;	// Set location

	format[localize "str_epoch_player_142",_text] call dayz_rollingMessages;
	
	if (DZE_GodModeBase && {!(_classname in DZE_GodModeBaseExclude)}) then {
		_object addEventHandler ["HandleDamage",{false}];
	};

	if (DZE_permanentPlot) then {
			_ownerID = _obj getVariable["ownerPUID","0"];
			_object setVariable ["ownerPUID",_ownerID,true];
			PVDZE_obj_Swap = [_objectCharacterID,_object,[_dir,_location,(player getVariable["PlayerUID",0]),_vector],_classname,_obj,player,[],dayz_authKey];
		} else {
			PVDZE_obj_Swap = [_objectCharacterID,_object,[_dir,_location, _vector],_classname,_obj,player,[],dayz_authKey];
		};
		publicVariableServer "PVDZE_obj_Swap";
		PVDZE_obj_Swap spawn server_swapObject;

	player reveal _object;

	// Tool use logger
	if(EAT_logMinorTool) then {
		EAT_PVEH_usageLogger = format["%1 %2 -- has used admin build to downgrade: %3",name player,(player getVariable["playerUID", 0]),_obj];
		publicVariableServer "EAT_PVEH_usageLogger";
	};

} else {
	localize "str_epoch_player_51" call dayz_rollingMessages;
};

s_player_downgrade_build = -1;
