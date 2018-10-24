waitUntil {!(isNil "BIS_fnc_init")};

if (isNil {DISPLAY_GEAR}) then {
	DISPLAY_GEAR = 106;
};

#define DISPLAY_MAIN (findDisplay DISPLAY_GEAR)
#define DISPLAY_VOICE (findDisplay 55)
uinamespace setVariable ["DISPLAY_MAIN",DISPLAY_MAIN];

createGearDialog [player, "RscDisplayGear"];
BUILD_Cond = true;

[] spawn {
	while {BUILD_Cond} do {
		waitUntil {!isNil{DISPLAY_MAIN} && !isNull(DISPLAY_MAIN)};
		[] spawn {DISPLAY_MAIN createDisplay "RscDisplayMission"};
		
		systemChat format ["Building Enabled. Press ESC twice to exit"];
	
		DISPLAY_VOICE displayAddEventHandler ["KeyDown", "_this call DZ_KeyDown_EH"];
		
		waitUntil {isNil{DISPLAY_MAIN} || isNull(DISPLAY_MAIN)};
		DISPLAY_MAIN closeDisplay 0;
		BUILD_Cond = false;
	};
};