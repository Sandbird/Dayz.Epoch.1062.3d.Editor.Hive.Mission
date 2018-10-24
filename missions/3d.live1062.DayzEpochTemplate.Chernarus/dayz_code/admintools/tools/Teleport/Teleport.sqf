private ["_done","_location","_locOK","_pos","_worked"];
if (!("ItemGPS" in items player)) then {player addweapon "ItemGPS";};
_done = false;
_locOK = true;
_worked = false;

teleport = {
	_pos = [_this select 0, _this select 1,_this select 2];

	if ((vehicle player) isKindOf "Air" && isEngineOn (vehicle player) && (speed (vehicle player)) > 20) then{
		(vehicle player) setpos [_pos select 0, _pos select 1, 1000];
		player setVariable["lastPos",0, true];
		_worked = true;
	} else {
		if ((vehicle player) != player && !((vehicle player) isKindOf "Ship")) then {
			_location = [_pos select 0, _pos select 1] findEmptyPosition [0,10];
			if (count _location < 1) then {
				"Unable to teleport here." call dayz_rollingMessages;
			} else {
				(vehicle player) setpos _location;
				_worked = true;
			};
		} else {
			(vehicle player) setpos [_pos select 0, _pos select 1, 0];
			_worked = true;
		};
	};

	openMap [false, false];
	TitleText [format[""], "PLAIN DOWN"];
	_done = true;

	// Tool use logger
	if(_worked) then {
		if(EAT_logMajorTool) then {
			EAT_PVEH_usageLogger = format["%1 %2 -- has teleported",name player,(player getVariable["playerUID", 0])];
			publicVariableServer "EAT_PVEH_usageLogger";
		};
	};
};

closedialog 0;
uiSleep 0.5;
"Click on the map to Teleport" call dayz_rollingMessages;

if(!(visibleMap)) then {
	openMap [true, false];
};

onMapSingleClick '[_pos select 0, _pos select 1, _pos select 2] call teleport';
waitUntil{_done || !(visibleMap)};
onMapSingleClick "";
