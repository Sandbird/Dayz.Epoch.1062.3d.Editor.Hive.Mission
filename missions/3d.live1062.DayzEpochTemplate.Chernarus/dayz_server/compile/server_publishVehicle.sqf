private ["_object","_worldspace","_location","_dir","_class","_uid","_dam","_hitpoints","_selection","_array","_damage","_fuel","_key","_totaldam","_spawnDMG","_characterID","_result","_outcome","_oid"];
//[_veh,[_dir,_location],"V3S_Civ",true]
#include "server_toggle_debug.hpp"

_object = 		_this select 0;
_worldspace = 	_this select 1;
_class = 		_this select 2;
_spawnDMG =		_this select 3;
_characterID =  _this select 4;

_fuel = 1;
_damage = 0;
_array = [];

#ifdef OBJECT_DEBUG
diag_log ("PUBLISH: Attempt " + str(_object));
#endif

_dir = 		_worldspace select 0;
_location = _worldspace select 1;
_uid = _worldspace call dayz_objectUID2;

if (_spawnDMG) then { 
	_fuel = 0;
	if (getNumber(configFile >> "CfgVehicles" >> _class >> "isBicycle") != 1) then {
		_totaldam = 0;
		_hitpoints = _object call vehicle_getHitpoints;
		{
			_dam = call generate_new_damage;
			_selection = getText(configFile >> "cfgVehicles" >> _class >> "HitPoints" >> _x >> "name");
			if (_dam > 0) then {
				_array set [count _array,[_selection,_dam]];
				_totaldam = _totaldam + _dam;
			};
		} count _hitpoints;	
		_damage = 0;
		_fuel = (random(DynamicVehicleFuelHigh-DynamicVehicleFuelLow)+DynamicVehicleFuelLow) / 100;
	};
};

//_key = str formatText["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance,_class,_damage,_characterID,_worldspace,[],_array,_fuel,_uid];
_key = format["INSERT INTO Object_DATA (`ObjectUID`, `Instance`, `Classname`, `Damage`, `CharacterID`, `Worldspace`, `Inventory`, `Hitpoints`, `Fuel`, `Datestamp`) VALUES ('%1','%2','%3','%4','%5','%6','%7','%8','%9', CURRENT_TIMESTAMP)",_uid, dayZ_instance, _class, _damage, _characterID, _worldspace, [], _array, _fuel];
_key call server_hiveWriteAndWait;

#ifdef OBJECT_DEBUG
diag_log ("HIVE: WRITE: "+ str(_key)); 
#endif



dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];

// GET DB ID
//_key = format["CHILD:388:%1:",_uid];
_key = format["SELECT ObjectID, count(*) as qexists from Object_DATA WHERE ObjectUID = '%1'",_uid];	
_result = _key call server_hiveReadWriteLarge;
_result = [_result, '"[', '['] call KRON_Replace;
_result = [_result, ']"', ']'] call KRON_Replace;
_result = call compile _result;
_result = _result select 1 select 0;
_objectCount = (_result select 1);


#ifdef OBJECT_DEBUG
diag_log ("HIVE-PubV: WRITE: "+ str(_key));
#endif


if(_objectCount == 0) then {
	deleteVehicle _object;
	diag_log("CUSTOM: failed to get id for : " + str(_uid));
} else {
	_oid = _result select 0;
	_object setVariable ["ObjectID", str(_oid), true];

	#ifdef OBJECT_DEBUG
	diag_log("CUSTOM: Selected " + str(_oid));
	#endif

	_object setVariable ["lastUpdate",diag_tickTime];
	_object setVariable ["CharacterID", _characterID, true];
	_object setDamage _damage;

	{
		_selection = _x select 0;
		_dam = _x select 1;
		if (_selection in dayZ_explosiveParts && _dam > 0.8) then {_dam = 0.8};
		[_object,_selection,_dam] call fnc_veh_setFixServer;
	} count _array;

	_object setFuel _fuel;
	_object setvelocity [0,0,1];
	_object call fnc_veh_ResetEH;

	PVDZE_veh_Init = _object;
	publicVariable "PVDZE_veh_Init";
	PVDZE_veh_Init call fnc_veh_ResetEH;

	diag_log ("PUBLISH: Created " + (_class) + " with ID " + str(_uid));
};

