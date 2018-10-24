private ["_player","_id","_lever","_randomX","_randomY","_randomZ","_randSleep","_pos","_smoke","_b1","_counter","_smokes","_dir","_pos2","_base"];

_player = _this select 1;
_machine = _this select 3;

_player removeAction s_player_fireworks;
s_player_fireworks = -1;
_machine setVariable["isActivated",true,true];
sleep 20;
_randExpo = [60,60,100,120,120,120] call BIS_fnc_selectRandom;
[_machine,_randExpo] execvm "custom\fireworks\alias_fireworks.sqf";
sleep _randExpo;
deleteVehicle _machine;