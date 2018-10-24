private["_max","_j","_menuCheckOk"];
_menuCheckOk = false; _max = 10; _j = 0;
snext = false; plist = []; pselect5 = "";

{if ((_x != player) && ((_x getVariable["playerUID", 0]) != "")) then {plist set [count plist, name _x];};} forEach entities "CAManBase";
{if ((count crew _x) > 0) then {{if ((_x != player) && ((_x getVariable["playerUID", 0]) != "")) then {plist set [count plist, name _x];};} forEach crew _x;};} foreach (entities "LandVehicle" + entities "Air" + entities "Ship");

EAT_pMenuTitle = "Teleport to Player:";

while {pselect5 == "" && !_menuCheckOk} do
{
	[_j, (_j + _max) min (count plist)] call EAT_fnc_playerSelect; _j = _j + _max;
	WaitUntil {pselect5 != "" || snext || commandingMenu == ""};
	_menuCheckOk = (commandingMenu == "");
	snext = false;
};

if (pselect5 != "exit" && pselect5 != "") then
{
	_name = pselect5;
	
	{
		scopeName "fn_tpToPlayer";
		if(name _x == _name) then {
			format["Teleporting to %1", _name] call dayz_rollingMessages;
			(vehicle player) attachTo [_x, [2, 2, 0]];
			uiSleep 0.25;
			detach (vehicle player);

			// Tool use logger
			if(EAT_logMajorTool) then {
				EAT_PVEH_usageLogger = format["%1 %2 -- has teleported to %3_%4",name player,(player getVariable["playerUID", 0]),_name,_x];
				publicVariableServer "EAT_PVEH_usageLogger";
			};
			breakOut "fn_tpToPlayer";
		};
	} forEach entities "CAManBase";
};
