private ["_mycv","_max","_j","_name","_player","_menuCheckOk"];

_mycv = cameraView;
_player = player;
_menuCheckOk = false;
_max = 10;
_j = 0;

EAT_pMenuTitle = "Spectate Player:";
snext = false;
plist = [];  
pselect5 = "";
spectate = true;

{if (_x != _player) then {plist set [count plist, name _x];};} forEach playableUnits;

while {pselect5 == "" && !_menuCheckOk} do
{
	[_j, (_j + _max) min (count plist)] call EAT_fnc_playerSelect; _j = _j + _max;
	WaitUntil {pselect5 != "" || snext || commandingMenu == ""};
	_menuCheckOk = (commandingMenu == "");
	snext = false;
};

if (pselect5!= "exit" && pselect5!="") then
{
	_name = pselect5;
	{
		if(format[name _x] == _name) then 
		{
			F6_Key = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 64) then {spectate = false;};"];	
			(vehicle _x) switchCamera "EXTERNAL";
			"F6 to return" call dayz_rollingMessages;
			waitUntil { !(alive _x) or !(alive player) or !(spectate)};
			(findDisplay 46) displayRemoveEventHandler ["KeyDown", F6_Key];
			player switchCamera _mycv;	

			// Tool use logger
			if(EAT_logMajorTool) then {
				EAT_PVEH_usageLogger = format["%1 %2 -- has begun spectating %3",name _player,(_player getVariable["playerUID", 0]),_name];
				publicVariableServer "EAT_PVEH_usageLogger";
			};
		};
	} forEach playableUnits;
};
spectate = false;
if (!spectate && pselect5 != "exit") then 
{	
	"Spectate done" call dayz_rollingMessages;

	// Tool use logger
	if(EAT_logMajorTool) then {
		EAT_PVEH_usageLogger = format["%1 %2 -- has stopped spectating %3",name _player,(_player getVariable["playerUID", 0]),_name];
		publicVariableServer "EAT_PVEH_usageLogger";
	};
};
