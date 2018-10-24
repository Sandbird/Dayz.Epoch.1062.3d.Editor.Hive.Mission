// by ALIAS
// nul = [obj_pozition,duration] execvm "ALfireworks\alias_rock.sqf";

private ["_al_project","_time_life_projectile","_obj","_firsound","_firflut","_dur","_ro","_ve","_bl"];

sleep random 2;

_obj = _this select 0;
_duration = _this select 1;

if (!isNil {_obj getVariable "is_ON"}) exitwith {};
//_obj setVariable ["is_ON",true,true];

endf=false;

[_duration] spawn {
	_dur=_this select 0;
	sleep _dur;
	endf=true;
};

while {!endf} do {
	_firsound = ["firework1","firework2","firework3"] call BIS_fnc_selectRandom;
	_firflut = ["fluier1","fluier2","fluier3","fluier4","fluier5","fluier6","fluier7"] call BIS_fnc_selectRandom;
	
	_ro =[1,0] call BIS_fnc_selectRandom;
	_ve =[1,0] call BIS_fnc_selectRandom;
	_bl =[1,0] call BIS_fnc_selectRandom;
	
	if ((_ro==0)and(_ve==0)and(_bl==0)) then {sleep 1} else {
	
	switch (_firflut) do {
  case "fluier1": {_time_life_projectile = 1.9};
  case "fluier2": {_time_life_projectile = 0.8};
  case "fluier3": {_time_life_projectile = 0.5};	
	case "fluier4": {_time_life_projectile = 0.8};
	case "fluier5": {_time_life_projectile = 1.2};
	case "fluier6": {_time_life_projectile = 0.8};
	case "fluier7": {_time_life_projectile = 1.4};
	};
	
	_al_project = "Rabbit" createVehicle (getPosASL _obj);
	//[_al_project,[_firflut,2000]] remoteExec ["say3d"];
	//[nil,_al_project,rSAY,["_firflut", 100]] call RE;
	_al_project say [_firflut,100];
	_al_project setVelocity [0,0,300];
	[_al_project,_time_life_projectile,_ro,_ve,_bl,_firsound] execVM "custom\fireworks\alias_rock.sqf";
	
	_gigi = _time_life_projectile+4;
	sleep _gigi;
	deleteVehicle _al_project;
	};
};