private ["_option","_params"];

_params = _this select 0;
_option = _this select 1;

PVDZ_getTickTime = [(player getVariable["playerUID", 0]),_params select 0,_params select 1,dayz_authKey];
publicVariable "PVDZ_getTickTime";

systemChat format["Changing server to %1",_option];