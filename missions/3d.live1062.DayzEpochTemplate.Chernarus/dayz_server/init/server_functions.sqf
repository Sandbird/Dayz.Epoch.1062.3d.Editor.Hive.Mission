//#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

//waitUntil {!isNil "bis_fnc_init"};

//[] spawn {[] execVM "dayz_server\infistar\AH.sqf";};

BIS_MPF_remoteExecutionServer = {
	if ((_this select 1) select 2 == "JIPrequest") then {
		[nil,(_this select 1) select 0,"loc",rJIPEXEC,[any,any,"per","execVM","ca\Modules\Functions\init.sqf"]] call RE;
	};
};

sched_sync = {
	//Send request
	private ["_hour","_minute","_date","_key","_result","_outcome"];
   // _key = "CHILD:307:";
	//_result = _key call server_hiveReadWrite;
	//_outcome = _result select 0;
	//_date = _result select 1; 
	_date = call compile ("real_date" callExtension "");
	if(dayz_ForcefullmoonNights) then {
			//_hour = _date select 3;
			//_minute = _date select 4;
			//Force full moon nights
			_date = [2013,8,3,11,0];
		};

		setDate _date;
		dayzSetDate = _date;
		publicVariable "dayzSetDate";
		diag_log ("TIME SYNC: Local Time set to " + str(_date));	
};

call compile preprocessFileLineNumbers "\z\addons\dayz_code\util\compile.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_code\loot\compile.sqf";

BIS_Effects_Burn = {};
dayz_disconnectPlayers = [];
dayz_serverKey = [];
for "_i" from 0 to 12 do {
	dayz_serverKey set [_i, ceil(random 128)];
};
dayz_serverKey = toString dayz_serverKey;

// :: EXTDB3 init
call compile preprocessFileLineNumbers "dayz_server\extDB\EXTDB_init.sqf";
extDB_async = compile preprocessFileLineNumbers "dayz_server\extDB\custom\asyncCall.sqf";
extDB_async_2 = compile preprocessFileLineNumbers "dayz_server\compile\fn_async.sqf";

//BIS_fnc_selectRandom = compile preprocessFileLineNumbers "dayz_code\system\functions\arrays\fn_selectRandom.sqf";
server_playerLogin = compile preprocessFileLineNumbers "dayz_server\compile\server_playerLogin.sqf";
server_playerSetup = compile preprocessFileLineNumbers "dayz_server\compile\server_playerSetup.sqf";
server_onPlayerDisconnect = compile preprocessFileLineNumbers "dayz_server\compile\server_onPlayerDisconnect.sqf";
server_updateObject = compile preprocessFileLineNumbers "dayz_server\compile\server_updateObject.sqf";
server_playerDied = compile preprocessFileLineNumbers "dayz_server\compile\server_playerDied.sqf";
server_publishObj = compile preprocessFileLineNumbers "dayz_server\compile\server_publishObject.sqf";	//Creates the object in DB
server_deleteObj = compile preprocessFileLineNumbers "dayz_server\compile\server_deleteObj.sqf"; 	//Removes the object from the DB
server_deleteObjDirect = compile preprocessFileLineNumbers "dayz_server\compile\server_deleteObjDirect.sqf"; 	//Removes the object from the DB, NO AUTH, ONLY CALL FROM SERVER, NO PV ACCESS
server_playerSync = compile preprocessFileLineNumbers "dayz_server\compile\server_playerSync.sqf";
zombie_findOwner = compile preprocessFileLineNumbers "dayz_server\compile\zombie_findOwner.sqf";
server_Wildgenerate = compile preprocessFileLineNumbers "dayz_server\compile\zombie_Wildgenerate.sqf";
base_fireMonitor = compile preprocessFileLineNumbers "\z\addons\dayz_code\system\fire_monitor.sqf";
//server_systemCleanup = compile preprocessFileLineNumbers "dayz_server\system\server_cleanup.sqf";
spawnComposition = compile preprocessFileLineNumbers "ca\modules\dyno\data\scripts\objectMapper.sqf"; //"\z\addons\dayz_code\compile\object_mapper.sqf";
server_sendToClient = compile preprocessFileLineNumbers "dayz_server\eventHandlers\server_sendToClient.sqf";
server_verifySender = compile preprocessFileLineNumbers "dayz_server\compile\server_verifySender.sqf";

// EPOCH ADDITIONS
server_swapObject = compile preprocessFileLineNumbers "dayz_server\compile\server_swapObject.sqf"; //Used to downgrade and upgrade Epoch buildables
server_publishVeh = compile preprocessFileLineNumbers "dayz_server\compile\server_publishVehicle.sqf"; //Used to spawn random vehicles by server
server_publishVeh2 = compile preprocessFileLineNumbers "dayz_server\compile\server_publishVehicle2.sqf"; //Used to purchase vehicles at traders
server_publishVeh3 = compile preprocessFileLineNumbers "dayz_server\compile\server_publishVehicle3.sqf"; //Used for car upgrades
server_tradeObj = compile preprocessFileLineNumbers "dayz_server\compile\server_tradeObject.sqf";
server_traders = compile preprocessFileLineNumbers "dayz_server\compile\server_traders.sqf";
server_spawnEvents = compile preprocessFileLineNumbers "dayz_server\compile\server_spawnEvent.sqf";
server_deaths = compile preprocessFileLineNumbers "dayz_server\compile\server_playerDeaths.sqf";
server_maintainArea = compile preprocessFileLineNumbers "dayz_server\compile\server_maintainArea.sqf";
server_checkIfTowed = compile preprocessFileLineNumbers "dayz_server\compile\server_checkIfTowed.sqf";
server_handleSafeGear = compile preprocessFileLineNumbers "dayz_server\compile\server_handleSafeGear.sqf";
spawn_ammosupply = compile preprocessFileLineNumbers "dayz_server\compile\spawn_ammosupply.sqf";
spawn_mineveins = compile preprocessFileLineNumbers "dayz_server\compile\spawn_mineveins.sqf";
spawn_roadblocks = compile preprocessFileLineNumbers "dayz_server\compile\spawn_roadblocks.sqf";
//spawn_vehicles = compile preprocessFileLineNumbers "dayz_server\compile\spawn_vehicles.sqf";
// Epoch Admin Tools
EAT_vehSpawn = compile preprocessFileLineNumbers "dayz_server\compile\EAT_vehSpawn.sqf";
EAT_CrateSpawn = compile preprocessFileLineNumbers "dayz_server\compile\EAT_crateSpawn.sqf";
EAT_serverAiSpawn = compile preprocessFileLineNumbers "dayz_server\compile\EAT_serverAiSpawn.sqf";


server_medicalSync = {
	_player = _this select 0;
	_array = _this select 1;
	
	_player setVariable ["USEC_isDead",(_array select 0)]; //0
	_player setVariable ["NORRN_unconscious",(_array select 1)]; //1
	_player setVariable ["USEC_infected",(_array select 2)]; //2
	_player setVariable ["USEC_injured",(_array select 3)]; //3
	_player setVariable ["USEC_inPain",(_array select 4)]; //4
	_player setVariable ["USEC_isCardiac",(_array select 5)]; //5
	_player setVariable ["USEC_lowBlood",(_array select 6)]; //6
	_player setVariable ["USEC_BloodQty",(_array select 7)]; //7
	// _wounds; //8
	// [_legs,_arms]; //9
	_player setVariable ["unconsciousTime",(_array select 10)]; //10
	_player setVariable ["blood_type",(_array select 11)]; //11
	_player setVariable ["rh_factor",(_array select 12)]; //12
	_player setVariable ["messing",(_array select 13)]; //13
	_player setVariable ["blood_testdone",(_array select 14)]; //14
};
/*
dayz_Achievements = {
	_achievementID = (_this select 0) select 0;
	_player = (_this select 0) select 1;
	_playerOwnerID = owner _player;
	
	_achievements = _player getVariable "Achievements";
	_achievements set [_achievementID,1];
	_player setVariable ["Achievements",_achievements];
};
*/

//Send fences to this array to be synced to db, should prove to be better performaince wise rather then updaing each time they take damage.
server_addtoFenceUpdateArray = {
	private ["_class","_clientKey","_damage","_exitReason","_index","_object","_playerUID"];
	_object = _this select 0;
	_damage = _this select 1;
	_playerUID = _this select 2;
	_clientKey = _this select 3;
	_index = dayz_serverPUIDArray find _playerUID;
	_class = typeOf _object;

	_exitReason = switch true do {
		//Can't use owner because player may already be dead, can't use distance because player may be far from fence
		case (_clientKey == dayz_serverKey): {""};
		case (_index < 0): {
			format["Server_AddToFenceUpdateArray error: PUID NOT FOUND ON SERVER. PV ARRAY: %1",_this]
		};
		case ((dayz_serverClientKeys select _index) select 1 != _clientKey): {
			format["Server_AddToFenceUpdateArray error: CLIENT AUTH KEY INCORRECT OR UNRECOGNIZED. PV ARRAY: %1",_this]
		};
		case !(_class isKindOf "DZ_buildables"): {
			format["Server_AddToFenceUpdateArray error: setDamage request on non DZ_buildable. PV ARRAY: %1",_this]
		};
		default {""};
	};
	
	if (_exitReason != "") exitWith {diag_log _exitReason};	
	
	_object setDamage _damage;

	if !(_object in needUpdate_FenceObjects) then {
		needUpdate_FenceObjects set [count needUpdate_FenceObjects, _object];
		if (_playerUID != "SERVER") then {
			diag_log format["DAMAGE: PUID(%1) requested setDamage %2 on fence %3 ID:%4 UID:%5",_playerUID,_damage,_class,(_object getVariable["ObjectID","0"]),(_object getVariable["ObjectUID","0"])];
		};
	};
};

vehicle_handleServerKilled = {
	private ["_unit","_killer"];
	_unit = _this select 0;
	_killer = _this select 1;
		
	[_unit,"killed",false,false,"SERVER",dayz_serverKey] call server_updateObject;
	_unit removeAllMPEventHandlers "MPKilled";
	_unit removeAllEventHandlers "Killed";
	_unit removeAllEventHandlers "HandleDamage";
	_unit removeAllEventHandlers "GetIn";
	_unit removeAllEventHandlers "GetOut";
};

check_publishobject = {
	private ["_saveObject","_allowed","_allowedObjects","_object","_playername"];

	_object = _this select 0;
	_playername = _this select 1;
	_allowed = false;

	#ifdef OBJECT_DEBUG
		diag_log format["DEBUG: Checking if Object: %1 is allowed, published by %2",_object,_playername];
	#endif

	if ((typeOf _object) in DayZ_SafeObjects) then {
		_saveObject = "DayZ_SafeObjects";
		_allowed = true;
	};
	
	//Buildings
	if (_object isKindOf "DZ_buildables") then {
		_saveObject = "DZ_buildables";
		_allowed = true;
	};
	
	#ifdef OBJECT_DEBUG
		diag_log format["DEBUG: Object: %1 published by %2 is allowed by %3",_object,_playername,_saveObject];
	#endif

	_allowed
};

server_hiveWrite = {
	private "_data";
	//_data = "HiveExt" callExtension _this;
	//_data = format["Arma2NETMySQLCommand ['%2',""%1""]",_this, DB_NAME];
	//SQL_RESULT = "Arma2Net.Unmanaged" callExtension _data;
	_data = format["%1",_this];
	SQL_RESULT = [_data,1] call extDB_async;
};

server_hiveWriteAndWait = {
	private "_data";
	//_data = "HiveExt" callExtension _this;
	//_data = format["Arma2NETMySQLCommand ['%2',""%1""]",_this, DB_NAME];
	//SQL_RESULT = "Arma2Net.Unmanaged" callExtension _data;
	_data = format["%1",_this];
	SQL_RESULT = [_data,2] call extDB_async;
};

server_hiveRead = {
	private["_key","_resultArray","_data","_dataf"];
	_key = _this;
	//_data = format["Arma2NETMySQLCommand ['%2',""%1""]",_key, DB_NAME];
	//SQL_RESULT = "Arma2Net.Unmanaged" callExtension _data;
	_data = format["%1",_key];
	_dataf = [_data,2] call extDB_async;
	_resultArray = call compile format ["%1",_dataf];
	if (isNil "_resultArray") then {_resultArray = "HIVE CONNECTION ERROR";};
	if ((_resultArray select 0) == 0) exitWith {diag_log format ["extDB: Protocol Error: %1", _resultArray]; []};
	if(count (_resultArray select 1) == 0) exitWith {[]};
	_resultArray = (_resultArray select 1);
	_resultArray
};

server_hiveReadWrite = {
	private ["_key","_resultArray","_data","_dataf"];
	_key = _this;
	//_data = "HiveExt" callExtension _key;
	//_resultArray = call compile str formatText["%1", _data];
	//if (isNil "_resultArray") then {_resultArray = "HIVE CONNECTION ERROR";};
	//_resultArray
	//_data = format["Arma2NETMySQLCommand ['%2',""%1""]",_key, DB_NAME];
	//SQL_RESULT = "Arma2Net.Unmanaged" callExtension _data;
	_data = format["%1",_key];
	//diag_log format [":::::::::::extDB3: Query:::::::::: %1", _key];
	_dataf = [_data,2] call extDB_async;
	//_result = call compile (_result select 0);  //extdb return
	_resultArray = call compile format ["%1",_dataf];
	if (isNil "_resultArray") then {_resultArray = "HIVE CONNECTION ERROR";};
	if ((_resultArray select 0) == 0) exitWith {diag_log format ["extDB: Protocol Error: %1", _resultArray]; []};
	if(count (_resultArray select 1) == 0) exitWith {[]};
	_resultArray = (_resultArray select 1);
	_resultArray
};

server_hiveReadWriteLarge = {
	private["_key","_resultArray","_data","_dataf"];
	_key = _this;
	//_data = "HiveExt" callExtension _key;
	//_resultArray = call compile _data;
	//_resultArray
	//_data = format["Arma2NETMySQLCommand ['%2',""%1""]",_key, DB_NAME];
	//SQL_RESULT = "Arma2Net.Unmanaged" callExtension _data;
	_data = format["%1",_key];
	//diag_log format [":::::::::::extDB3: LargeQuery:::::::::: %1", _key];
	_resultArray = [_data,2] call extDB_async;
	//_resultArray = call compile _resultArray;
	//_resultArray = call compile _dataf;
	_resultArray
};

onPlayerDisconnected "[_uid,_name] call server_onPlayerDisconnect;";

server_getStatsDiff = {
	private ["_player","_playerUID","_new","_old","_result","_statsArray"];
	_player = _this select 0;
	_playerUID = _this select 1;
	_result = [];
	_statsArray = missionNamespace getVariable _playerUID;
	
	if (isNil "_statsArray") exitWith {
		diag_log format["Server_getStatsDiff error: playerUID %1 not found on server",_playerUID];
		[0,0,0,0,0]
	};
	
	{
		_new = _player getVariable [_x,0];
		_old = _statsArray select _forEachIndex;
		_result set [_forEachIndex, (_new - _old)];
		_statsArray set [_forEachIndex, _new]; //updates original var too
	} forEach ["humanity","zombieKills","headShots","humanKills","banditKills"];
	
	#ifdef PLAYER_DEBUG
	diag_log format["Server_getStatsDiff - Object:%1 Diffs:%2 New:%3",_player,_result,_statsArray];
	#endif
	
	_result
};

//seems max is 19 digits
dayz_objectUID2 = {
    private["_position","_dir","_time" ,"_key"];
	_dir = _this select 0;
	_time = round diag_tickTime;
	if (_time > 99999) then {_time = round(random 99999);}; //prevent overflow if server isn't restarted
	_key = "";
	_position = _this select 1;
	_key = format["%1%2%3%4", round(_time + abs(_position select 0)), round(_dir), round(abs(_position select 1)), _time];
	_key;
};

dayz_recordLogin = {
	private ["_key","_status","_name"];
	//_key = format["CHILD:103:%1:%2:%3:",_this select 0,_this select 1,_this select 2]; //playerID, charterId, action
	//_key call server_hiveWrite;
	_key = format["INSERT INTO `Player_LOGIN` (`PlayerUID`,`CharacterID`, `Datestamp`, `Action`) VALUES ('%1', '%2', CURRENT_TIMESTAMP, '%3')",_this select 0,_this select 1,_this select 2];
	_key call server_hiveWrite;
		
	_status = switch (1==1) do {
		case ((_this select 2) == 0): { "CLIENT LOADED & PLAYING" };
		case ((_this select 2) == 1): { "LOGIN PUBLISHING, Location " +(_this select 4) };
		case ((_this select 2) == 2): { "LOGGING IN" };
		case ((_this select 2) == 3): { "LOGGED OUT, Location " +(_this select 4) };
	};
	
	_name = if (typeName (_this select 3) == "ARRAY") then { toString (_this select 3) } else { _this select 3 };
	//diag_log format["INFO - Player: %1(UID:%3/CID:%4) Status: %2",_name,_status,(_this select 0),(_this select 1)];
};

generate_new_damage = {
	private "_damage";
    _damage = ((random(DynamicVehicleDamageHigh-DynamicVehicleDamageLow))+DynamicVehicleDamageLow) / 100;
	_damage
};

// coor2str: convert position to a GPS coordinates
fa_coor2str = {
	private["_pos","_res","_nearestCity","_town"];

	_pos = +(_this);
	if (count _pos < 1) then { _pos = [0,0]; }
	else { if (count _pos < 2) then { _pos = [_pos select 0,0]; };
	};
	_nearestCity = nearestLocations [_pos, ["NameCityCapital","NameCity","NameVillage","NameLocal"],1000];
	_town = "Wilderness";
	if (count _nearestCity > 0) then {_town = text (_nearestCity select 0)};
	_res = format["%1 [%2]", _town, mapGridPosition _pos];

	_res
};

// print player player PID and name. If name unknown then print UID.
fa_plr2str = {
	private["_x","_res","_name"];
	_x = _this;
	_res = "nobody";
	if (!isNil "_x") then {
		_name = _x getVariable ["bodyName", nil];
		if ((isNil "_name" OR {(_name == "")}) AND ({alive _x})) then { _name = name _x; };
		if (isNil "_name" OR {(_name == "")}) then { _name = "UID#"+(_x getVariable ["playerUID", "0"]); };
		_res = format["PID#%1(%2)", owner _x, _name ];
	};
	_res
};

array_reduceSize = {
	private ["_array1","_array","_count","_num"];
	_array1 = _this select 0;
	_array = _array1 - ["Hatchet_Swing","Crowbar_Swing","Machete_Swing","Bat_Swing","BatBarbed_Swing","BatNails_Swing","Fishing_Swing","Sledge_Swing","CSGAS"];
	_count = _this select 1;
	_num = count _array;
	if (_num > _count) then {
		_array resize _count;
	};
	_array
};

spawn_vehicles = {
	private ["_random","_lastIndex","_index","_vehicle","_velimit","_qty","_isAir","_isShip","_position","_dir","_istoomany","_veh","_objPosition","_iClass","_num","_allCfgLoots"];
	// do not make _roadList, _buildingList or _serverVehicleCounter private in this function
	#include "\z\addons\dayz_code\util\Math.hpp"
	#include "\z\addons\dayz_code\util\Vector.hpp"
	#include "\z\addons\dayz_code\loot\Loot.hpp"
	
	while {count AllowedVehiclesList > 0} do {
		// BIS_fnc_selectRandom replaced because the index may be needed to remove the element
		_index = floor random count AllowedVehiclesList;
		_random = AllowedVehiclesList select _index;
		_vehicle = _random select 0;
		_velimit = _random select 1;
		_qty = {_x == _vehicle} count serverVehicleCounter;
		//diag_log format["::::::::: _velimit: %1,  _velimit:%2,   _random:%3,   _qty:%4", _velimit, _velimit, _random, _qty];
		
		if (_qty <= _velimit) exitWith {}; // If under limit allow to proceed

		// vehicle limit reached, remove vehicle from list
		// since elements cannot be removed from an array, overwrite it with the last element and cut the last element of (as long as order is not important)
		_lastIndex = (count AllowedVehiclesList) - 1;
		if (_lastIndex != _index) then {AllowedVehiclesList set [_index, AllowedVehiclesList select _lastIndex];};
		AllowedVehiclesList resize _lastIndex;
	};

	if (count AllowedVehiclesList == 0) then {
		diag_log "DEBUG: unable to find suitable random vehicle to spawn";
	} else {
		// add vehicle to counter for next pass
		serverVehicleCounter set [count serverVehicleCounter,_vehicle];

		// Find Vehicle Type to better control spawns
		_isAir = _vehicle isKindOf "Air";
		_isShip = _vehicle isKindOf "Ship";
		if (_isShip or _isAir) then {
			if (_isShip) then {
				// Spawn anywhere on coast on water
				waitUntil{!isNil "BIS_fnc_findSafePos"};
				_position = [MarkerPosition,0,(getMarkerSize "center") select 1,10,1,2000,1] call BIS_fnc_findSafePos;
				//_position = [MarkerPosition,0,(MarkerPosition select 1),10,1,2000,1] call BIS_fnc_findSafePos;
				diag_log("DEBUG: spawning boat near coast " + str(_position));
			} else {
				// Spawn air anywhere that is flat
				waitUntil{!isNil "BIS_fnc_findSafePos"};
				_position = [MarkerPosition,0,(getMarkerSize "center") select 1,10,0,2000,0] call BIS_fnc_findSafePos;
				//_position = [MarkerPosition,0,(MarkerPosition select 1),10,0,2000,0] call BIS_fnc_findSafePos;
				diag_log("DEBUG: spawning air anywhere flat " + str(_position));
			};
		} else {
			// Spawn around buildings and 50% near roads
			if ((random 1) > 0.5) then {	
				waitUntil{!isNil "BIS_fnc_selectRandom"};
				_position = RoadList call BIS_fnc_selectRandom;
				_position = _position modelToWorld [0,0,0];	
				waitUntil{!isNil "BIS_fnc_findSafePos"};
				_position = [_position,0,10,10,0,2000,0] call BIS_fnc_findSafePos;
				diag_log("DEBUG: spawning near road " + str(_position));
			} else {
				waitUntil{!isNil "BIS_fnc_selectRandom"};
				//diag_log format["BuildingList LIST: %1, BuildingList];
				_position = BuildingList call BIS_fnc_selectRandom;
				_position = _position modelToWorld [0,0,0];
				waitUntil{!isNil "BIS_fnc_findSafePos"};
				_position = [_position,0,40,5,0,2000,0] call BIS_fnc_findSafePos;	
				diag_log("DEBUG: spawning around buildings " + str(_position));
			};
		};
		// only proceed if two params otherwise BIS_fnc_findSafePos failed and may spawn in air
		if ((count _position) == 2) then {
			_position set [2,0];
			_dir = round(random 180);
			_istoomany = _position nearObjects ["AllVehicles",50];
			if((count _istoomany) > 0) exitWith { diag_log("DEBUG: Too many vehicles at " + str(_position)); };
		
			//_veh = createVehicle [_vehicle, _position, [], 0, "CAN_COLLIDE"];
			//_veh setPos _position;
			_veh = _vehicle createVehicle [0,0,0];
			_veh setDir _dir;
			_veh setPos _position;
			
			if(DZEdebug) then {
				_marker = createMarker [str(_position) , _position];
				_marker setMarkerShape "ICON";
				_marker setMarkerType "DOT";
				_marker setMarkerText _vehicle;
			};	
			
			_objPosition = getPosATL _veh;
		
			clearWeaponCargoGlobal  _veh;
			clearMagazineCargoGlobal  _veh;

			// Add 0-3 loots to vehicle using random loot groups
			_num = floor(random 4);
			_allCfgLoots = ["Trash","Trash","Consumable","Consumable","Generic","Generic","MedicalLow","MedicalLow","clothes","tents","backpacks","Parts","pistols","AmmoCivilian"];
			
			for "_x" from 1 to _num do {
				_iClass = _allCfgLoots call BIS_fnc_selectRandom;
				_lootGroupIndex = dz_loot_groups find _iClass;
				Loot_InsertCargo(_veh, _lootGroupIndex, 1);
			};

			[_veh,[_dir,_objPosition],_vehicle,true,"0"] call server_publishVeh;
			
			if (_num > 0) then {
				vehiclesToUpdate set [count vehiclesToUpdate,_veh];
			};
		};
	};
};

if (StaticDayOrDynamic) then {
	LIVE_DATE = [2013,8,3,11,0];
	setDate LIVE_DATE;
}else{
	LIVE_DATE = call compile ("real_date" callExtension "");
	setDate LIVE_DATE;
};

// Precise base building 1.0.5
call compile preprocessFileLineNumbers "dayz_server\compile\kk_functions.sqf";
//#include "mission_check.sqf"
