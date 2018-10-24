/*
	Spawns several random "Supply_Crate_DZE" across map.
	Lootable by destroying and then opening with crowbar.
	Currently outputs vehicle ammo defined in Land_ammo_supply_wreck CfgVehicles class
*/

private ["_position","_veh","_istoomany"];
// do not make _roadList or _buildingList private in this function

_position = RoadList call BIS_fnc_selectRandom;
_position = _position modelToWorld [0,0,0];
_position = [_position,5,20,5,0,2000,0] call BIS_fnc_findSafePos;

if ((count _position) == 2) then {
	_istoomany = _position nearObjects ["All",5];
	if ((count _istoomany) > 0) exitWith {};
	
	//_veh = createVehicle ["Supply_Crate_DZE",_position, [], 0, "CAN_COLLIDE"];
	_veh = "Supply_Crate_DZE" createVehicle [0,0,0];
	_veh enableSimulation false;
	_veh setDir round(random 360);
	_veh setPos _position;
	_veh setVariable ["ObjectID","1",true];
	//diag_log format["Spawned Ammo Supply at  %1", _position];
};