if (isNil "oneTime") then { 	//run init.sqf only once	
oneTime = true; 
if (isServer) then {
	if (isnil "bis_fnc_init") then {
	_side = createCenter sideLogic;
	_group = createGroup _side;
	_logic = _group createUnit ["FunctionsManager", [0,0,0], [], 0, "NONE"];
	};
	waituntil {!isnil "bis_fnc_init"};
};
diag_log("-------------------------------------- GOT IN -----------------------------");
//Server settings
dayZ_instance = 11; //Instance ID of this server
dayZ_serverName = "Editor"; //Shown to all players in the bottom left of the screen (country code + server number)
//Game settings
dayz_antihack = 0; // DayZ Antihack / 1 = enabled // 0 = disabled
dayz_REsec = 0; // DayZ RE Security / 1 = enabled // 0 = disabled
dayz_enableRules = true; //Enables a nice little news/rules feed on player login (make sure to keep the lists quick).
dayz_quickSwitch = false; //Turns on forced animation for weapon switch. (hotkeys 1,2,3) False = enable animations, True = disable animations
dayz_POIs = false; //Adds Point of Interest map additions (negatively impacts FPS)
dayz_infectiousWaterholes = false; //Randomly adds some bodies, graves and wrecks by ponds (negatively impacts FPS)
dayz_ForcefullmoonNights = true; // Forces night time to be full moon.
dayz_randomMaxFuelAmount = 500; //Puts a random amount of fuel in all fuel stations.

//DayZMod presets
dayz_presets = "Custom"; //"Custom","Classic","Vanilla","Elite"

//Only need to edit if you are running a custom server.
if (dayz_presets == "Custom") then {
	dayz_enableGhosting = false; //Enable disable the ghosting system.
	dayz_ghostTimer = 60; //Sets how long in seconds a player must be disconnected before being able to login again.
	dayz_spawnselection = 0; //(Chernarus only) Turn on spawn selection 0 = random only spawns, 1 = spawn choice based on limits
	dayz_spawncarepkgs_clutterCutter = 0; //0 = loot hidden in grass, 1 = loot lifted, 2 = no grass
	dayz_spawnCrashSite_clutterCutter = 0;	// heli crash options 0 = loot hidden in grass, 1 = loot lifted, 2 = no grass
	dayz_spawnInfectedSite_clutterCutter = 0; // infected base spawn 0 = loot hidden in grass, 1 = loot lifted, 2 = no grass 
	dayz_bleedingeffect = 2; //1 = blood on the ground (negatively impacts FPS), 2 = partical effect, 3 = both
	dayz_OpenTarget_TimerTicks = 60 * 10; //how long can a player be freely attacked for after attacking someone unprovoked
	dayz_nutritionValuesSystem = true; //true, Enables nutrition system, false, disables nutrition system.
	dayz_classicBloodBagSystem = true; // disable blood types system and use the single classic ItemBloodbag
	dayz_enableFlies = false; // Enable flies on dead bodies (negatively impacts FPS).
};

//Temp settings
dayz_DamageMultiplier = 2; //1 - 0 = Disabled, anything over 1 will multiply damage. Damage Multiplier for Zombies.
dayz_maxGlobalZeds = 500; //Limit the total zeds server wide.
dayz_temperature_override = false; // Set to true to disable all temperature changes.

//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio true;
//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
// May prevent "how are you civillian?" messages from NPC
enableSentences false;

// EPOCH CONFIG VARIABLES START //
#include "\z\addons\dayz_code\configVariables.sqf" // Don't remove this line
// See the above file for a full list including descriptions and default values

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
DefaultTruePreMadeFalse = true;                    //Read player's data from the database, or Run with the default editor character (false: editor player, true: read from database)
MarkerP = createMarker ["center", [7839,0,8414]];  //Open your mission.sqm and search for "center". Put your position values here.
MarkerP 	setMarkerSize [7500,7000]; 						   //Open your mission.sqm and search for "center". Put your a,b values here.
DB_NAME = "dayz_cherno"; 													 // Put your test database's name here. It is the same name as the one you put in extdb3-conf.ini for @extDB
DZEdebug = false;  																 // Debug messages on log file (very helpful when you are coding), disabled by default
player setIdentity "My_Player";									   //check description.ext file....There is no other way to get the name of the player in the editor..(so leave this alone)

if(DefaultTruePreMadeFalse) then {
	////////////////////////////////
	// Setup your database character (enter your playerUID from database)
	///////////////////////////////
	player setVariable ["playerUID", "76111111111111111", true];    // <<<<<<<<<< Change this to your playerUID found in the player_data table
}else{
	////////////////////////////
	// Setup a default character (if you dont want to use DB character, aka DefaultTruePreMadeFalse = false;)
	////////////////////////////
	player setVariable ["CharacterID", "1", true];		// Set here the characterID of the player. It can be anything...just leave it 1 if you want.
	player setVariable ["playerUID", "111111", true]; // Set here the playerUID of the player you want to have. (by default the 2nd bot inside the game is friend to player with id 111111 for testing reasons)
	player setVariable["Z_globalVariable", 100000];
	player setVariable["Z_BankVariable", 100000];
	player setVariable["Z_MoneyVariable", 100000];
	player setVariable["humanity", 11000];
	player setVariable["humanKills", 10];
	player setVariable["banditKills", 20];
	player setVariable["zombieKills", 30];
	player setVariable ["friendlies", ["222222","333333"], true]; //Both DZE_Friends and this must be set for friendlies to work properly
	DZE_Friends = ["222222","333333"];
};
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

StaticDayOrDynamic = true; // Check server_functions.sqf. Setting to false will take your REAL date/time. Set to true if you want a fixed day, It is set at the bottom of server_functions.sqf
//Settings for 3d editor's character (not database, DefaultTruePreMadeFalse = false;)
DefaultMagazines 	= ["ItemBandage","ItemBandage","ItemGoldBar","ItemMorphine","IRStrobe","ItemZombieParts","FoodSteakCooked","ItemSodaCoke","ItemBloodbag","20Rnd_762x51_SB_SCAR","20Rnd_762x51_SB_SCAR","15Rnd_9x19_M9SD","PartGeneric","PartGeneric","PartWheel","PartWheel"];
DefaultWeapons 		=  ["ItemMap","ItemWatch","ItemToolbox","ItemFlashlightRed","ItemMachete","M9SD","SCAR_H_CQC_CCO_SD","ItemGPS","Binocular_Vector","ItemKnife"];
DefaultBackpack 	= "DZ_LargeGunBag_EP1";
DefaultBackpackWeapon = "ChainsawP";
DefaultBackpackMagazines = ["30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","20Rnd_762x51_SB_SCAR","20Rnd_762x51_SB_SCAR","SmokeShell","ItemMixOil","ItemMixOil","ItemMixOil"];
//To show debug messages in the RPT file

dayz_paraSpawn = false; // Halo spawn
DZE_BackpackAntiTheft = false; // Prevent stealing from backpacks in trader zones
DZE_BuildOnRoads = false; // Allow building on roads
DZE_PlayerZed = true; // Enable spawning as a player zombie when players die with infected status
DZE_R3F_WEIGHT = false; // Enable R3F weight. Players carrying too much will be overburdened and forced to move slowly.
DZE_StaticConstructionCount = 0; // Steps required to build. If greater than 0 this applies to all objects.
DZE_GodModeBase = false; // Make player built base objects indestructible
DZE_requireplot = 1; // Require a plot pole to build  0 = Off, 1 = On
DZE_PlotPole = [30,45]; // Radius owned by plot pole [Regular objects,Other plotpoles]. Difference between them is the minimum buffer between bases.
DZE_BuildingLimit = 150; // Max number of built objects allowed in DZE_PlotPole radius
DZE_SafeZonePosArray = [[[6325,7807,0],100],[[4063,11664,0],100],[[11447,11364,0],100],[[1606,7803,0],100],[[12944,12766,0],100],[[12060,12638,0],100]]; // Format is [[[3D POS],RADIUS],[[3D POS],RADIUS]]; Stops loot and zed spawn, salvage and players being killed if their vehicle is destroyed in these zones.
DZE_SelfTransfuse = true; // Allow players to bloodbag themselves
DZE_selfTransfuse_Values = [12000,15,120]; // [blood amount given, infection chance %, cooldown in seconds]
MaxDynamicDebris = 10; // Max number of random road blocks to spawn around the map
MaxVehicleLimit = 10; // Max number of random vehicles to spawn around the map
spawnArea = 1400; // Distance around markers to find a safe spawn position
spawnShoremode = 1; // Random spawn locations  1 = on shores, 0 = inland
EpochUseEvents = false; //Enable event scheduler. Define custom scripts in dayz_server\modules to run on a schedule.
EpochEvents = [["any","any","any","any",30,"crash_spawner"],["any","any","any","any",0,"crash_spawner"],["any","any","any","any",15,"supply_drop"]];
// EPOCH CONFIG VARIABLES END //
/*
diag_log 'dayz_preloadFinished reset';
dayz_preloadFinished=nil;
onPreloadStarted "diag_log [diag_tickTime,'onPreloadStarted']; dayz_preloadFinished = false;";
onPreloadFinished "diag_log [diag_tickTime,'onPreloadFinished']; dayz_preloadFinished = true;";
with uiNameSpace do {RscDMSLoad=nil;}; // autologon at next logon
*/
enableSaving [false, false];	

// load string functions 
_nul=[] execVM "custom\KRON_Strings.sqf";
initialized = false;
if (DefaultTruePreMadeFalse) then {
	call compile preprocessFileLineNumbers "dayz_server\extDB\custom\init.sqf";
};
call compile preprocessFileLineNumbers "dayz_code\init\variables.sqf";
progressLoadingScreen 0.05;
call compile preprocessFileLineNumbers "dayz_code\init\publicEH.sqf";
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";
progressLoadingScreen 0.15;
call compile preprocessFileLineNumbers "dayz_code\init\compiles.sqf";
call compile preprocessFileLineNumbers "custom\click_actions\init.sqf";
call compile preprocessFileLineNumbers "dayz_code\admintools\config.sqf"; // Epoch admin Tools config file
call compile preprocessFileLineNumbers "dayz_code\admintools\variables.sqf"; // Epoch admin Tools variables
progressLoadingScreen 0.25;
if (!DefaultTruePreMadeFalse) then {
	call compile preprocessFileLineNumbers "dayz_code\init\setupChar.sqf";
}else{
	dayz_loadScreenMsg = localize 'str_login_missionFile';
	//call compile preprocessFileLineNumbers "dayz_code\init\setupChar_Database.sqf";	
};
progress_monitor = [] execVM "dayz_code\system\progress_monitor.sqf";
call compile preprocessFileLineNumbers "server_traders.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\mission\chernarus11.sqf"; //Add trader city objects locally on every machine early

setTerrainGrid 25;
if (dayz_REsec == 1) then {call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\REsec.sqf";};


if (isServer) then {
	if (dayz_POIs && (toLower worldName == "chernarus")) then {call compile preprocessFileLineNumbers "\z\addons\dayz_code\system\mission\chernarus\poi\init.sqf";};
	call compile preprocessFileLineNumbers "dayz_server\system\dynamic_vehicle.sqf";
	if (DefaultTruePreMadeFalse) then {
	_playerMonitor = 	[] execVM "dayz_code\system\player_monitor.sqf";
	};
	call compile preprocessFileLineNumbers "dayz_server\system\server_monitor.sqf";
	execVM "dayz_server\traders\chernarus11.sqf"; //Add trader agents
	
	//Get the server to setup what waterholes are going to be infected and then broadcast to everyone.
	if (dayz_infectiousWaterholes && (toLower worldName == "chernarus")) then {execVM "\z\addons\dayz_code\system\mission\chernarus\infectiousWaterholes\init.sqf";};
	
	// Lootable objects from CfgTownGeneratorDefault.hpp
	if (dayz_townGenerator) then { execVM "\z\addons\dayz_code\system\mission\chernarus\MainLootableObjects.sqf"; };
};

if (isServer) then {
	if (toLower worldName == "chernarus") then {
		execVM "\z\addons\dayz_code\system\mission\chernarus\hideGlitchObjects.sqf";
	};
	
	//Admintools init
	[] execVM "dayz_code\admintools\Activate.sqf"; // Epoch admin tools
	//execVM "\z\addons\dayz_code\system\antihack.sqf";
	
	//Enables Plant lib fixes
	if (dayz_townGenerator) then { execVM "\z\addons\dayz_code\compile\client_plantSpawner.sqf"; };
	
	//[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
	if (DZE_R3F_WEIGHT) then {execVM "dayz_code\external\R3F_Realism\R3F_Realism_Init.sqf";};

	waitUntil {scriptDone progress_monitor};
};


//Start Dynamic Weather
////[0.1, 0.9, 1] execVM "dayz_code\external\DynamicWeatherEffects.sqf";
////#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"

// Set a fixed Fullmoon night
//EAT_PVEH_SetDate = [2012,6,4,4,0];
//setDate EAT_PVEH_SetDate;

setviewdistance 2500;   //View Distance limit

// Small admin menu
player addaction [("<t color=""#0074E8"">" + ("Fast Tools") +"</t>"),"custom\keybinds.sqf","",5,false,true,"",""];
if (DefaultTruePreMadeFalse) then {
	player addaction [("<t color=""#0074E8"">" + ("Add BankMonkey") +"</t>"),"custom\money.sqf","",5,false,true,"",""];
};
// This is used when you are building something. Temporarily it creates a display 46 to capture keystrokes. You need to activate it AFTER you start building something.
player addAction [("<t color=""#39C1F3"">" + ("Enable Keyboard actions") + "</t>"),"custom\monitor_building.sqf", "", 1, false,true,"",""]; 

};
