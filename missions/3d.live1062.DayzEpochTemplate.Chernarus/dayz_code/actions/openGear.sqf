private ["_unit","_unconcious","_inVeh","_alive"];

call fnc_usec_medic_removeActions;
_unit = _this select 3;
_unconcious = _unit getVariable ["NORRN_unconscious", false];
_inVeh = vehicle player != player;
_alive = alive _unit;


if (_unconcious && !_inVeh && _alive) then {
	DZE_GearCheckBypass = true; //Bypass gear menu checks since dialog will always open on _unit's gear
	player action ["Gear", _unit];
};