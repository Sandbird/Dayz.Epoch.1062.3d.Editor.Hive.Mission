private["_display","_control1","_control2","_watermark"];
disableSerialization;
//diag_log "DEBUG: loadscreen guard started.";

// Logo watermark: adding a logo in the bottom left corner of the screen with the server name
if (!isNil "dayZ_serverName") then {
	5 cutRsc ["wm_disp","PLAIN"];
	_watermark = (uiNamespace getVariable "wm_disp") displayCtrl 1;
	_watermark ctrlSetText dayZ_serverName;
	if (profileNamespace getVariable ["streamerMode",0] == 1) then {_watermark ctrlShow false;};
};

if (dayz_enableRules && (profileNamespace getVariable ["streamerMode",0] == 0)) then {
	dayz_rulesHandle = execVM "rules.sqf";
};

if (dayz_groupSystem) then {execVM "\z\addons\dayz_code\groups\init.sqf";};

//diag_log [ __FILE__, __LINE__, "Looping..."];


