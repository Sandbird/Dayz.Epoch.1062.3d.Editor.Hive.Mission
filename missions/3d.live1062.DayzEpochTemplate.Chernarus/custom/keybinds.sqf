adminmenu =
[
	["",true],
		['Generate Key', [2], '', -5, [['expression', '[] call admin_generatekey;']], '1', '1'],
		['Show ID', [3], '', -5, [['expression', '[] call admin_showid;']], '1', '1'],
		['Lower Terrain', [4], '', -5, [['expression', '[] call admin_low_terrain;']], '1', '1'],
		['GOD', [5], '', -5, [['expression', '[] call admingod;']], '1', '1'],
		['Find Plotpoles', [6], '', -5, [['expression', '[] call admin_findplots;']], '1', '1'],
		['TP to coords', [7], '', -5, [['expression', '[] call admin_tp;']], '1', '1'],
		['Display Scanner', [8], '', -5, [['expression', '[] call admin_displays;']], '1', '1'],
		["", [-1], "", -5, [["expression", ""]], "1", "0"],
	["Exit", [13], "", -3, [["expression", ""]], "1", "1"]		
];

	admin_tp =
	{
		_pArray = [6371.95,7758.18];  ///EDIT them (x,y)
		player setPos _pArray;
	};

	admin_showid =
	{
		_obj = cursortarget;
		if (!isNull _obj) then
		{
			_charID = _obj getVariable ["CharacterID","0"];
			_objID 	= _obj getVariable["ObjectID","0"];
			_objUID	= _obj getVariable["ObjectUID","0"];
			_lastUpdate = _obj getVariable ["lastUpdate",time];
			
			systemchat format["%1: charID: %2, objID: %3, objUID: %4, lastUpdate: %5",typeOF _obj,_charID,_objID,_objUID,_lastUpdate];
		};
	};

	admin_generatekey =
	{
		private ["_ct","_id","_result","_inventory","_backpack"];
		_ct = cursorTarget;
		if (!isNull _ct) then {
			if (_ct distance player > 12) exitWith {cutText [format["%1 is to far away.",typeOF _ct], "PLAIN"];};
			if !((_ct isKindOf "LandVehicle") || (_ct isKindOf "Air") || (_ct isKindOf "Ship")) exitWith {cutText [format["%1 is not a vehicle..",typeOF _ct], "PLAIN"];};
			
			_id = _ct getVariable ["CharacterID","0"];
			_id = parsenumber _id;
			if (_id == 0) exitWith {cutText [format["%1 has ID 0 - No Key possible.",typeOF _ct], "PLAIN"];};
			if ((_id > 0) && (_id <= 2500)) then {_result = format["ItemKeyGreen%1",_id];};
			if ((_id > 2500) && (_id <= 5000)) then {_result = format["ItemKeyRed%1",_id-2500];};
			if ((_id > 5000) && (_id <= 7500)) then {_result = format["ItemKeyBlue%1",_id-5000];};
			if ((_id > 7500) && (_id <= 10000)) then {_result = format["ItemKeyYellow%1",_id-7500];};
			if ((_id > 10000) && (_id <= 12500)) then {_result = format["ItemKeyBlack%1",_id-10000];};
			
			_inventory = (weapons player);
			_backpack = ((getWeaponCargo unitbackpack player) select 0);
			if (_result in (_inventory+_backpack)) then
			{
				if (_result in _inventory) then {cutText [format["Key [%1] already in your inventory!",_result], "PLAIN"];};
				if (_result in _backpack) then {cutText [format["Key [%1] already in your backpack!",_result], "PLAIN"];};
			}
			else
			{
				player addweapon _result;
				cutText [format["Key [%1] added to inventory!",_result], "PLAIN"];
			};
		};
	};

	admin_low_terrain = {
		if (isNil "admin_terrain") then {admin_terrain = true;} else {admin_terrain = !admin_terrain};
		if (admin_terrain) then {
		setTerrainGrid 50;
		hint "Terrain Low";
		cutText [format["Terrain Low"], "PLAIN DOWN"];
		_savelog = format["%1 Terrain Low",name player];
		PVAH_WriteLogReq = [_savelog];
		publicVariableServer "PVAH_WriteLogReq";
		} else {
		setTerrainGrid 25;
		hint "Terrain Normal";
		cutText [format["Terrain Normal"], "PLAIN DOWN"];
		_savelog = format["%1 Terrain Normal",name player];
		PVAH_WriteLogReq = [_savelog];
		publicVariableServer "PVAH_WriteLogReq";
		};
	};

	admingod =
	{
		if (isNil 'gmdadmin') then {gmdadmin = 0;};
		if (gmdadmin == 0) then
		{
			gmdadmin = 1;
			hint 'God ON';
			
			[] spawn {
				while {gmdadmin == 1} do
				{
					dayz_temperatur = dayz_temperaturnormal;
					dayz_hunger = 0;
					dayz_thirst = 0;
					fnc_usec_damageHandler = {};
					player_zombieCheck = {};
					player_zombieAttack = {};
					player allowDamage false;
					player removeAllEventhandlers 'handleDamage';
					player addEventhandler ['handleDamage', {false}];
					sleep 0.5;
				};
				sleep 1;
				player_zombieCheck = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieCheck.sqf';
				player_zombieAttack = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieAttack.sqf';
				fnc_usec_damageHandler = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_damageHandler.sqf';
				player allowDamage true;
				player removeAllEventHandlers 'HandleDamage';
				player addeventhandler ['HandleDamage',{_this call fnc_usec_damageHandler;} ];
			};
			
			
			_savelog = format['%1 G_o_d ON',name player];
			PVAH_WriteLogReq = [_savelog];
			publicVariableServer 'PVAH_WriteLogReq';
		}
		else
		{
			gmdadmin = 0;
			hint 'God OFF';
			
			fnc_usec_damageHandler = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_damageHandler.sqf';
			player allowDamage true;
			player removeAllEventHandlers 'HandleDamage';
			player addeventhandler ['HandleDamage',{_this call fnc_usec_damageHandler;} ];
			
			
			_savelog = format['%1 G_o_d OFF',name player];
			PVAH_WriteLogReq = [_savelog];
			publicVariableServer 'PVAH_WriteLogReq';
		};
	};

	admin_findplots = {
		private ["_nul","_markHouse","_idx","_makeMarker","_start","_object","_objects","_total","_bldg","_pos","_bldgType","_bbox","_height","_marker","_holder"];
		#include "functions.hpp" // Marker
		// find lakes
			systemchat("Searching for plotpoles...");
			_objects = nearestObjects [player,[],150];
			_total = count _objects;
			_start = time;
			for "_i" from 0 to _total-1 do {
				_object = _objects select _i;
				_bldg = _object;
				_pos = getPos _object;
				_bldgType = typeOf _object;
				_bbox = boundingBox _bldg;
				_height = ((_bbox select 1) select 2) - ((_bbox select 0) select 2);
				
				if ([str _object,"sign_one_leg"] call KRON_StrInStr) then {
				_idx = [_pos,"START","ColorBlue",1,"",_idx] call _makeMarker;	//on map
				 _holder = createVehicle ["Sign_arrow_down_large_EP1", _pos, [], 0, "CAN_COLLIDE"];
				 //player reveal _veh;
				 _holder hideObject true;
		   	 _marker = [_holder,[_pos select 0,_pos select 1,_height+50],"ColorYellow"] spawn _markHouse;  //3d	
				};
				//diag_log format["Time:%1", time];
				if (time-_start>2) then {
					titleText [format["Searching for plotpoles, %1%2 done",round (_i*100/_total),"%"],"plain"];
					_start = time;
					sleep 10;
					deletevehicle _holder;
					deleteMarker _marker;
				};
			};

		sleep 2;
		_idx = 0;
		while {true} do {
			_idx = _idx + 1;
			_marker = format["mrk_%1",_idx];
			if (getMarkerPos _marker select 0==0) exitWith {};
			//diag_log (_marker);
			deleteMarker _marker;
		};
	};
	
	admin_displays = {
		[] execVM "custom\displayscanner.sqf";
	};

showCommandingMenu "#USER:adminmenu";
