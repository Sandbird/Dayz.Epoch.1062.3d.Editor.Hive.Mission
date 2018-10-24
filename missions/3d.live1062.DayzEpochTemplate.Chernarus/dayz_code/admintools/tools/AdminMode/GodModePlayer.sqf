/* 
	Heals all damage and makes the user invincible to damage by everything 
	excluding antihack killing a hacker.
*/
if(isNil "EAT_playerGod2") then {EAT_playerGod2 = true;} else {EAT_playerGod2 = !EAT_playerGod2};

private["_player","_vehicle"];
_player = player;

if (EAT_playerGod2) then
{
	// Tool use logger
	if(EAT_logMajorTool) then {
		EAT_PVEH_usageLogger = format["%1 %2 -- has _player god mode",name _player,(_player getVariable["playerUID", 0])];
		publicVariableServer "EAT_PVEH_usageLogger";
	};

	player_zombieCheck = {};
	fnc_usec_damageHandler = {};
	fnc_usec_unconscious = {};
	_player removeAllEventHandlers "handleDamage";
	_player addEventHandler ["handleDamage", { false }];	
	_player allowDamage false;
	r_player_unconscious = false;
	r_player_infected = false;
	r_player_injured = false;
	r_player_inpain = false;
	r_player_loaded = false;
	r_player_cardiac = false;
	r_player_lowblood = false;
	r_fracture_legs = false;
	r_fracture_arms = false;
	r_player_blood = 11999;
	r_player_timeout = 0;
	r_handlerCount = 0;
	dayz_sourceBleeding = objNull;
	dayz_hunger	= 0;
	dayz_thirst = 0;
	dayz_temperatur = 100;
	disableUserInput false;
	_player setVariable ["USEC_injured",false,true];
	{_player setVariable[_x,false,true];} forEach USEC_woundHit;
	_player setVariable ["unconsciousTime", r_player_timeout, true];
	_player setHit ['legs',0];
	_player setVariable ['hit_legs',0,false];
	_player setVariable['medForceUpdate',true,true];
} else {
	// Tool use logger
	if(EAT_logMajorTool) then {
		EAT_PVEH_usageLogger = format["%1 %2 -- has DISABLED _player god mode",name _player,(_player getVariable["playerUID", 0])];
		publicVariableServer "EAT_PVEH_usageLogger";
	};
	if(!inZone) then {
		player_zombieCheck = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_zombieCheck.sqf";
		fnc_usec_damageHandler = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandler.sqf";
		fnc_usec_unconscious = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_unconscious.sqf";
		_player addEventHandler ["handleDamage", {true}];
		_player removeAllEventHandlers "handleDamage";
		_player allowDamage true;
	};
};
