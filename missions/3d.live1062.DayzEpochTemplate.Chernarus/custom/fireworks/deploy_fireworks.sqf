private ["_inCombat","_timeout","_smQTY","_finished","_object"];

closedialog 0;
_timeout = player getVariable["combattimeout", 0];
_inCombat = if (_timeout >= diag_tickTime) then { true } else { false };

if (_inCombat) then {
	cutText [format["You cant deploy it while in combat."], "PLAIN DOWN"];
};

_smQTY = {_x == "SMAW_HEDP"} count magazines player;
if (_smQTY >= 1) then {
	
	dayz_actionInProgress = true;
	_finished = ["Medic",1] call fn_loopAction;
	if (!_finished) exitWith {dayz_actionInProgress = false; "Canceled Deploying Fireworks!" call dayz_rollingMessages;};
	player removeMagazine "SMAW_HEDP";
	_object  = createVehicle ["SkeetMachine",getpos player,[], 0, ""];
	_object setpos  (player modelToWorld [0,2,0]);
	_object setDir ([_object, player] call my_BIS_fnc_dirTo)-180;
	sleep 1;
	_object setVariable ["ObjectID", "1", true];
	_object setVariable ["ObjectUID", "1", true];
	_object setVariable ["DZAI",1,true];        
	dayz_actionInProgress = false;
	//cutText ["You used your toolbox to build a Fireworks Machine!", "PLAIN DOWN"];
	cutText ["\nNow activate it using your Radio and RUN AWAY!!!", "PLAIN DOWN"];
	sleep 2;
} else {
	cutText [format["You need: 1x(SMAW_HEDP) to build this."], "PLAIN DOWN"];
};