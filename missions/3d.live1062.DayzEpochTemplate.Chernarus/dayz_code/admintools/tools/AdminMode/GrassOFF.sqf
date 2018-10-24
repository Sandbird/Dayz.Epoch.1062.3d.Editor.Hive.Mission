// Toggle grass on or off for better visibility/performance
private ["_toggle"];
if(isNil "grassToggle") then {grassToggle = true;} else {grassToggle = !grassToggle};

if (grassToggle) then {
	_toggle = "on";
	setterraingrid 50;
}else{
	_toggle = "off";
	setterraingrid 25;
};

// Tool use logger
if(EAT_logMinorTool) then {
	EAT_PVEH_usageLogger = format["%1 %2 -- has turned grass %3",name player,(player getVariable["playerUID", 0]),_toggle];
	publicVariableServer "EAT_PVEH_usageLogger";
};
