
/************** Epoch Admin Tools Variables **************/

	//Replace 111111111 with your ID. 
	EAT_superAdminList = [
	player getVariable ["playerUID","0"], // <player name>
	"111111" // <player name>
	];
	EAT_adminList = [
	"999999999", // <player name>
	"999999999" // <player name>
	];
	EAT_modList = [
	"999999999", // <player name>
	"999999999" // <player name>
	];
	
	//Enable/Disable weather/time change menu. This may cause server to revert to mid-day on restart.
	EAT_wtChanger = true;


	//This creates a log in your server\EpochAdminToolLogs\toolUsageLog.txt REQUIRES: EATadminLogger.dll
		EAT_logMajorTool = false; //A major tool is a strong tool with high possibility for exploitation
		EAT_logMinorTool = false;//A minor tool is a weak tool with low possibility for exploitation


/************** Use Debug Monitor? *****************/
	EAT_DebugMonitor = true;

/************** Safe Zone Variables *****************/
	EAT_safeZones = true; //Enable the player safe zones script? REQUIRED for the other variables to take effect
	EAT_szVehicleGod = true; // Protect vehicles in the safe zone
	EAT_szDetectTraders = true; // This can USUALLY detect the MAJOR THREE traders (no aircraft/bandit/hero)
	EAT_szUseCustomZones = false; // Allows you to set your own zone positions (Works with auto detect)
	EAT_szPlotPoleZones = false; // NOT WORKING YET. Makes EVERY player plot pole area a safe zone
	EAT_szAntiTheft = true; // Disable stealing from inventory while in zone (allows interaction with friend inventory)
	EAT_szAiShield = false; // Remove AI in a radius around the zone
	EAT_szAiDistance = 100; // Distance to remove AI from players in a zone
	EAT_szZombieShield = true; // Remove zombies near players
	EAT_szZombieDistance = 20; // Distance to remove zombies from player in the zone
	EAT_szUseSpeedLimits = true; // Enforce a speed limit for vehicles to stop from pushing players out of zone
	EAT_szSpeedLimit = 35; // Max speed for vehicles inside the zones
	EAT_messageType = "DynamicText"; // Options: Hint, cutText, DynamicText - Do not use Hint if you have the debug monitor enabled.
	EAT_szAdminWeapon = true; // Allow admins to use weapons in the safe zones? (True = yes)
	
	// You can find these in the sensors section of the mission.sqm for each map
	// Format: [[X,Z,Y],RADIUS] Z can be left 0 in most cases
	EAT_szCustomZones = [
		// Cherno zones that can't be auto detected:
		[[1606.6443,289.70795,7803.5156],100], // Bandit
		[[12944.227,210.19823,12766.889],100], // Hero
		[[12060.471,158.85699,12638.533],100] // Aircraft (NO COMMA ON LAST LINE)
		// ALWAYS LEAVE OFF THE LAST "," OR THIS WILL BREAK
	];


/************** Admin/Mod mode Variables **************/
	
	// Defines the default on and off for admin/mod mode options
	// ALL items can be turned on or off during gameplay, these are just defaults
	EAT_playerGod = true;
	EAT_vehicleGod = true;
	EAT_playerESP = true;
	EAT_enhancedESP = true;
	EAT_grassOff = true;
	EAT_infAmmo = true;
	EAT_speedBoost = true;
	EAT_fastWalk = true;
	EAT_invisibility = true;
	EAT_flying = true;
	EAT_adminBuild = true;
	
	// Change the maximum build distance for placable base items
	DZE_buildMaxMoveDistance = 30;

	
/************** Activation Variables ***************/

EAT_AdminMenuHotkey = false; // Use hotkey to activate admin tools.
EAT_ActionMenuHotkey = false; // Use hotkey to activate action menu.

/*************** AI Spawner Options ****************/

EAT_HumanityGainLoss = 25;
EAT_aiDeleteTimer = 600;

/************** Action Menu Variables **************/

	/*
		Give players an actions menu? (dance, deploy bike/mozzie, flip car)
		Default: true
	*/
	EAT_ActionMenuPlayers = false;

	/*
		Give admins the same action menu above? (not really needed unless you are a playing admin)
		Default: false
	*/
	EAT_ActionMenuAdmins = true;


	/****** Bike variables ******/

	//Allow player to build a bike?
	EAT_AllowBuildBike = true;

	// This option requires players to have a toolbox to build a bike (consumes the toolbox)
	EAT_RequireToolBoxBike = true;

	// This option requires players to have the parts for building a bike (consumes the parts)
	// Required parts: two wheels, one scrap metal
	EAT_RequirePartsBike = false;

	// This option dictates if players are allowed to repack a bike to get their items back
	EAT_AllowPackBike = true;


	/****** Mozzie variables ******/

	//Allow player to build a Mozzie?
	EAT_AllowBuildMozzie = true;

	// This option requires players to have a toolbox to build a Mozzie (consumes the toolbox)
	EAT_RequireToolBoxMozzie = false;

	// This option requires players to have the parts for building a Mozzie (consumes the parts)
	// Required parts: main rotor, two scrap, one engine, one jerry can (full)
	EAT_RequirePartsMozzie = true;

	// This option dictates if players are allowed to repack a mozzie to get their items back
	EAT_AllowPackMozzie = true;


	/****** Misc ******/
		
	// Allow players to flip their vehicles rightside up
	EAT_AllowFlipVehicle = true;
		
	// Allow players to commit suicide
	EAT_AllowSuicide = true;
		
	// Allow players to use the movement menu (dance)
	EAT_AllowMovementMenu = true;
	
	// Allow players to set view distance
	EAT_AllowViewDistance = true;
	
	// Allow players to remove grass
	EAT_AllowToggleTerrain = true;

	/* 
		Allow players to open a help ticket with the admins.
		The help queue can be viewed via the admin menu.
		The player can NOT spam the admins.
	*/
	EAT_AllowContactAdmin = false;

		/*
			Stops spamming of the contact admin. If it is enabled and a user contacts an admin
			the given number of times they will get a white screen for EAT_blindTime seconds and 
			the contact feature will be disabled
		*/
		EAT_enableAntiSpam = false;
		EAT_antiSpamLimit = 15; // default 15 contacts
		EAT_blindTime = 30; // default 30 seconds
		
		
		
diag_log("Admin Tools: config.sqf loaded");
