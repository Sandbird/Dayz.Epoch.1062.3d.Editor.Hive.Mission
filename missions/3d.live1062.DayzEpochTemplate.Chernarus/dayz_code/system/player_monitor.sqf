private ["_currentWpn","_currentAnim","_playerObjName","_playerUID","_state","_debug","_survival","_msg","_lastAte","_lastDrank","_usedFood","_usedWater","_inventory","_backpack","_model","_totalmins","_days","_hours","_mins"];
if(isNil "DZEdebug") then { DZEdebug = false; };
_debug = DZEdebug;
///////////////////////////////////////////////////////////
dayz_versionNo = getText(configFile >> "CfgMods" >> "DayZ" >> "version");
dayz_loadScreenMsg = localize 'STR_AUTHENTICATING';
Dayz_loginCompleted = nil;
PVCDZ_plr_Login = [];
_timeStart = diag_tickTime;
_readytoAuth = false;
_startCheck = 0;
_schedulerStarted=false;
//_spawnSelection = 9;
_timeNemGender = 0;
_timeNemRegion = 0;
_playerName = name player;
diag_log("Server as player in SetupChar is:"+_playerName);
if (_playerName == '__SERVER__') exitWith {};
if (_debug) then {
diag_log ("DAYZ: CLIENT IS RUNNING DAYZ_CODE " + str(dayz_versionNo));
};

//if(!isServer) then {
	
dayz_loadScreenMsg = localize 'str_player_loading'; 
if (_debug) then {diag_log [diag_tickTime,'Loading'];};
///////////////////////////////////////////////////////////
	//if(!isnil "BIS_MPF_InitDone") then {
		if (_debug) then {diag_log [diag_tickTime,'Enable_Sim'];};

		_myAssets = getText(configFile >> "CfgPatches" >> "dayz_communityassets" >> "dayzVersion");
		_mySfx = getNumber(configFile >> "CfgPatches" >> "dayz_sfx" >> "dayzVersion");
		_myAnim = getNumber(configFile >> "CfgPatches" >> "dayz_anim" >> "dayzVersion");
		_myEpoch = getText(configFile >> "CfgPatches" >> "dayz_epoch" >> "dayzVersion");
		_myEpochB = getText(configFile >> "CfgPatches" >> "dayz_epoch_b" >> "dayzVersion");

		/*
		_myCCrossbow = getNumber(configFile >> "CfgPatches" >> "community_crossbow" >> "dayzVersion");
		_myDayz = getNumber(configFile >> "CfgPatches" >> "dayz" >> "dayzVersion");
		_myBuildings = getNumber(configFile >> "CfgPatches" >> "dayz_buildings" >> "dayzVersion");
		_myCWeapons = getNumber(configFile >> "CfgPatches" >> "dayz_communityweapons" >> "dayzVersion");
		_myEquip = getNumber(configFile >> "CfgPatches" >> "dayz_equip" >> "dayzVersion");
		_mySFX = getNumber(configFile >> "CfgPatches" >> "dayz_sfx" >> "dayzVersion");
		_myVechicles = getNumber(configFile >> "CfgPatches" >> "dayz_vehicles" >> "dayzVersion");
		_myWeapons = getNumber(configFile >> "CfgPatches" >> "dayz_weapons" >> "dayzVersion");
		*/

		if (_debug) then {
			diag_log format["DayZ Version: DayZ_Anim: %1 DayZ_SFX: %2 DayZ_Assets: %3",_myAnim, _mySfx,_myAssets];
		};
	//};
///////////////////////////////////////////////////////////
	if((!isNull player) and (player == player)) then {
			dayz_loadScreenMsg = localize 'str_player_waiting_creation'; 

			_playerUID = player getVariable ["playerUID", 0];//getPlayerUID player;
			progressLoadingScreen 0.6;
			if (_debug) then {diag_log [diag_tickTime,'Collect'];};
	};
///////////////////////////////////////////////////////////

	if(!(isNil "_playerUID")) then {
		if (_debug) then {diag_log [diag_tickTime,'Server_Loading'];};_myTime = diag_tickTime;
		dayz_loadScreenMsg = localize 'str_player_waiting_start';

		if (_debug) then {
			diag_log ("Server Loading");
			diag_log ("PLOGIN: Waiting for server to start authentication");
		};
	};
	
	dayz_clientPreload = true;
	dayz_preloadFinished = true;
///////////////////////////////////////////////////////////

	dayz_myPosition = getPosATL player;
///////////////////////////////////////////////////////////
	
///////////////////////////////////////////////////////////
	//if(!isNil "sm_done") then {
			if (_debug) then {diag_log [diag_tickTime,'Request'];};

			dayz_loadScreenMsg = localize 'str_player_request';

			_msg = [];
			progressLoadingScreen 0.65;
			PVDZ_plr_Login1 = [_playerUID,player];
			publicVariableServer "PVDZ_plr_Login1";
			[_playerUID,player] call server_playerLogin;
			diag_log ['Sent to server: PVDZ_plr_Login1', PVDZ_plr_Login1]; 
			PVDZ_send = [player,"dayzSetDate",[player]];
			publicVariableServer "PVDZ_send";
			[player,"dayzSetDate",[player]] call server_sendToClient;
			diag_log ['Sent to server: PVDZ_send', PVDZ_send]; 
			_myTime = diag_tickTime;
	//};
///////////////////////////////////////////////////////////
	if(count (PVCDZ_plr_Login) > 1) then {
		_msg = 	PVCDZ_plr_Login;
		if (_debug) then {diag_log format['PVCDZ_plr_Login in player_monitor came back with:  %1', _msg];}; 
		//"PVCDZ_plr_Login in player_monitor came back with:  [6,[["SCAR_L_CQC_CCO_SD","ItemCompass","ItemMap","ItemToolbox","ItemWatch","ItemMatchbox","ItemKeyYellow1035","ItemHatchet","ItemGPS","ItemFlashlight","M9_SD_DZ"],["ItemPainkiller","ItemBloodbag","ItemMorphine","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","ItemBriefcase60oz","ItemBandage","ItemAntibacterialWipe","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD"],""],["DZ_LargeGunBag_EP1",[[],[]],[["FoodCanHerpy","FoodCanSardines","ItemSodaDrwaste","ItemSodaSmasht","ItemMorphine","ItemGoldBar2oz","ItemGoldBar","30Rnd_556x45_StanagSD","30Rnd_762x39_AK47"],[1,1,1,1,1,20,20,1,1]]],[91,7141,7141],false,"DayZ Epoch 1.0.6.2","Survivor2_DZ",true,false,0,"[]",0,0,10]"
	};
///////////////////////////////////////////////////////////
	if(!(isNil "PVCDZ_plr_PlayerAccepted")) then {
		PVCDZ_plr_PlayerAccepted = nil;
	};
///////////////////////////////////////////////////////////
	if (_debug) then {diag_log [diag_tickTime,'Parse_Login'];};
	progressLoadingScreen 0.8;
	_charID		= str(_msg select 0);
	_inventory	= _msg select 1;
	_backpack	= _msg select 2;
	_survival 	= _msg select 3;
	_isNew 		= _msg select 4;
	//_state 		= _msg select 5;
	_version	= _msg select 5;
	_model		= _msg select 6;
	_patch = {};

	_isHiveOk = false;
	_newPlayer = false;
	_isInfected = false;
	_characterCoins = 0;
	_globalCoins = 0;
	_bankCoins = 0;

	if (count _msg > 7) then {
		_isHiveOk = _msg select 7;
		_newPlayer = _msg select 8;
		_isInfected = _msg select 9;
		_characterCoins		= _msg select 11;
		_globalCoins		= _msg select 12;
		_bankCoins		= _msg select 13;
		diag_log ("PLAYER RESULT: " + str(_isHiveOk));
	};

	dayz_loadScreenMsg = localize 'str_player_creating_character'; 
	if (_isHiveOk) then { if (!_schedulerStarted) then { _schedulerStarted=true; execVM 'dayz_code\system\scheduler\sched_init.sqf'; }; };
	if (_debug) then {
		diag_log ("PLOGIN: authenticated with : " + str(_msg));
	};

	//Not Equal Failure

	if (isNil "_model") then {
		_model = "Survivor2_DZ";
		diag_log ("PLOGIN: Model was nil, loading as survivor");
	};

	if (_model == "") then {
		_model = "Survivor2_DZ";
		diag_log ("PLOGIN: Model was empty, loading as survivor");
	};

	if (_model == "Survivor1_DZ") then {
		_model = "Survivor2_DZ";
	};
	_isHack = false;
	if (_model == "hacker") then {
		_isHack = true;
	};
///////////////////////////////////////////////////////////
	if (!_isNew) then {
		_timeNemRegion = nil;
		_timeNemGender = nil;
	};
///////////////////////////////////////////////////////////
	dayz_playerName = name player;
	gear_done = true;
	_model call player_switchModel;
	player allowDamage false;
	_lastAte = _survival select 1;
	_lastDrank = _survival select 2;

	_usedFood = 0;
	_usedWater = 0;

	_inventory call player_gearSet;

	//Assess in backpack
	if (count _backpack > 0) then {
		//Populate
		_backpackType = 	_backpack select 0;
		_backpackWpn = 		_backpack select 1;
		_backpackMagTypes = [];
		_backpackMagQty = [];
		if (count _backpackWpn > 0) then {
			_backpackMagTypes = (_backpack select 2) select 0;
			_backpackMagQty = 	(_backpack select 2) select 1;
		};
		_countr = 0;
		_backpackWater = 0;

		//Add backpack
		if (_backpackType != "") then {
			_isOK = 	isClass(configFile >> "CfgVehicles" >>_backpackType);
			if (_isOK) then {
				player addBackpack _backpackType; 
				dayz_myBackpack =	unitBackpack player;
				
				//Fill backpack contents
				//Weapons
				_backpackWpnTypes = [];
				_backpackWpnQtys = [];
				if (count _backpackWpn > 0) then {
					_backpackWpnTypes = _backpackWpn select 0;
					_backpackWpnQtys = 	_backpackWpn select 1;
				};
				_countr = 0;
				{
					if(_x in (DZE_REPLACE_WEAPONS select 0)) then {
						_x = (DZE_REPLACE_WEAPONS select 1) select ((DZE_REPLACE_WEAPONS select 0) find _x);
					};
					dayz_myBackpack addWeaponCargoGlobal [_x,(_backpackWpnQtys select _countr)];
					_countr = _countr + 1;
				} forEach _backpackWpnTypes;
				
				//Magazines
				_countr = 0;
				{
					if (_x == "BoltSteel") then { _x = "1Rnd_Arrow_Wood" }; // Convert BoltSteel to WoodenArrow
					if (dayz_classicBloodBagSystem) then {
						if (_x in dayz_typedBags) then {_x = "ItemBloodbag"};
					} else {
						if (_x == "ItemBloodbag") then { _x = "bloodBagONEG" }; // Convert ItemBloodbag into universal blood type/rh bag
					};
					dayz_myBackpack addMagazineCargoGlobal [_x,(_backpackMagQty select _countr)];
					_countr = _countr + 1;
				} forEach _backpackMagTypes;
				
				dayz_myBackpackMags =	getMagazineCargo dayz_myBackpack;
				dayz_myBackpackWpns =	getWeaponCargo dayz_myBackpack;
			} else {
				dayz_myBackpack		=	objNull;
				dayz_myBackpackMags = [];
				dayz_myBackpackWpns = [];
			};
		} else {
			dayz_myBackpack		=	objNull;
			dayz_myBackpackMags =	[];
			dayz_myBackpackWpns =	[];
		};
	} else {
		dayz_myBackpack		=	objNull;
		dayz_myBackpackMags =	[];
		dayz_myBackpackWpns =	[];
	};
	//gear_done = true;
	
	PVCDZ_plr_Login2 = [];
	PVDZ_plr_Login2 = [_charID,player,_inventory];
	publicVariable "PVDZ_plr_Login2";
	[_charID,player,_inventory] call server_playerSetup;
	//if (_debug) then {diag_log ['Sent to server: PVDZ_plr_Login2', PVDZ_plr_Login2];}; 	
	dayz_loadScreenMsg =  "Requesting Character data from server";
	progressLoadingScreen 0.9;
	
///////////////////////////////////////////////////////////

	if (count (PVCDZ_plr_Login2) > 0) then {
		//_msg = 	PVCDZ_plr_Login2;
		//_msg = 		player getVariable["worldspace",[]];
		//if (_debug) then {diag_log format['PVCDZ_plr_Login2 in player_monitor came back with:  %1', _msg];}; 
		//_msg = player getVariable["worldspace",[]];
			//diag_log "####PVCDZ_plr_Login2 Finished";
			//diag_log "Finished...";
			diag_log format['PVDZ_plr_Login2 came back with: %1', PVCDZ_plr_Login2]; 
	
				//Phase Two
				if (_debug) then {diag_log [diag_tickTime,'Phase_Two'];};dayz_loadScreenMsg = localize 'str_login_characterData'; 

				_worldspace = 	PVCDZ_plr_Login2 select 0;
				_state =			PVCDZ_plr_Login2 select 1;
				dayz_authKey = PVCDZ_plr_Login2 select 2;

				player setVariable ["Achievements",[],false];

				_setDir = 			_worldspace select 0;
				_setPos = 			_worldspace select 1;

				player setDir _setDir;
				player setPosATL _setPos;

				if (isNil "freshSpawn") then {
					freshSpawn = 0;
				};

				{
					if (player getVariable["hit_"+_x,false]) then { 
						[player,_x] spawn fnc_usec_damageBleed; 
						PVDZ_hlt_Bleed = [player,_x];
						publicVariableServer "PVDZ_hlt_Bleed"; // draw blood stream on character, on all gameclients
						[player,_x] spawn fnc_usec_damageBleed;
						
					};
				} forEach USEC_typeOfWounds;
				//Legs and Arm fractures
				_legs = player getVariable ["hit_legs",0];
				_arms = player getVariable ["hit_hands",0];

				if (_legs > 1) then {
					player setHit["legs",1];
					r_fracture_legs = true;
				};
				if (_arms > 1) then {
					player setHit["hands",1];
					r_fracture_arms = true;
				};

				//Record current weapon state
				dayz_myWeapons = 		weapons player;		//Array of last checked weapons
				dayz_myItems = 			items player;		//Array of last checked items
				dayz_myMagazines = 	magazines player;

				//dayz_playerUID = _playerUID;

				//Work out survival time  [91,7141,7141]
				_totalMins = _survival select 2;
				_days = floor (_totalMins / 1440);
				_totalMins = (_totalMins - (_days * 1440));
				_hours = floor (_totalMins / 60);
				_mins =  (_totalMins - (_hours * 60));

				player setVariable ["SurvivalTime",(_survival select 3),false];

				//player variables
				dayz_characterID =		_charID;
				dayz_myCursorTarget = 	objNull;
				dayz_myPosition = 		getPosATL player;	//Last recorded position
				dayz_lastMeal =			(_lastAte * 60);
				dayz_lastDrink =		(_lastDrank * 60);
				dayz_zombiesLocal = 	0;			//Used to record how many local zombies being tracked
				dayz_Survived = [_days,_hours,_mins,(_survival select 3)];  //total alive dayz
				dayz_loginTime = diag_tickTime;

				//load in medical details
				r_player_dead = 		player getVariable["USEC_isDead",false];
				r_player_unconscious = 	player getVariable["NORRN_unconscious", false];
				r_player_infected =	player getVariable["USEC_infected",false];
				r_player_injured = 	player getVariable["USEC_injured",false];
				r_player_inpain = 		player getVariable["USEC_inPain",false];
				r_player_cardiac = 	player getVariable["USEC_isCardiac",false];
				r_player_lowblood =	player getVariable["USEC_lowBlood",false];
				r_player_blood = 		player getVariable["USEC_BloodQty",r_player_bloodTotal];
				r_player_timeout = player getVariable["unconsciousTime",0];

				if (Z_SingleCurrency) then {
					player setVariable [Z_MoneyVariable, _characterCoins, true];
					player setVariable [Z_globalVariable, _globalCoins, true];
					player setVariable [Z_BankVariable, _bankCoins, true];
				};
				
			dayz_musicH = [] spawn player_music;
			dayz_slowCheck = 	[] spawn player_spawn_2;
			Dayz_logonTime = daytime;
			Dayz_logonDate = floor ((_survival select 0) / 1440);
			_position = getPosATL player;
			_radius = 200;
			//Current amounts
			dayz_spawnZombies = {alive _x AND local _x} count (_position nearEntities ["zZombie_Base",_radius]);
			dayz_CurrentNearByZombies = {alive _x} count (_position nearEntities ["zZombie_Base",_radius]);

				//Hunger/Thirst
				_messing =			player getVariable["messing",[0,0,0]];
				dayz_hunger = 	_messing select 0;
				dayz_thirst = 		_messing select 1;
				dayz_nutrition  = 	_messing select 2;

				//player setVariable ["humanity",-3000, true];
			///////////////////////////////////////////////////////////
				_myTime = diag_tickTime;
				if(!isNil "dayzSetDate") then {
					diag_log ['Date & time received:', dayzSetDate];
					setDate dayzSetDate;
					diag_log ['Local date on this client:', date];
				};
			///////////////////////////////////////////////////////////
				if (_debug) then {diag_log [diag_tickTime,'Stream'];};
				dayz_loadScreenMsg = localize 'str_login_spawningLocalObjects';
			///////////////////////////////////////////////////////////
				if(((!dayz_townGenerator or (!isNil 'dayz_plantSpawner_done' && {dayz_plantSpawner_done == 2})))) then{  //if(((!dayz_townGenerator or (!isNil 'dayz_plantSpawner_done' && {dayz_plantSpawner_done == 2})) && (!isNil 'BIS_fnc_init'))) then{
					if (_debug) then {diag_log [diag_tickTime,'Load_In'];};
					progressLoadingScreen 0.95;
					dayz_loadScreenMsg = localize 'str_player_setup_completed';
					_torev4l=nearestObjects [_setPos, Dayz_plants + DayZ_GearedObjects + ["AllVehicles","WeaponHolder"], 50];
					{ _null = [_x,0] spawn object_roadFlare; } count (allMissionObjects "RoadFlare");
					{ _null = [_x,1] spawn object_roadFlare; } count (allMissionObjects "ChemLight");
					{
					  _fadeFire = _x getVariable['fadeFire', true];
					  if (!_fadeFire) then {
					    nul = [_x,2,0,false,false] spawn BIS_Effects_Burn;
					  };
					} count allMissionObjects "SpawnableWreck";
					{deleteVehicle _x} count (_setPos nearEntities ["zZombie_Base",30]);
					player setDir _setDir;

					if (dayz_paraSpawn && freshSpawn == 2) then {
						player setPosATL [_setPos select 0,_setPos select 1,DZE_HaloSpawnHeight];
					} else {
						player setPosATL _setPos;
						if (surfaceIsWater respawn_west_original) then {player call fn_exitSwim;};
					};

					player setVelocity [0,0,0.5];
					{player reveal _x} count _torev4l;
					dayz_myPosition = _setPos;
					player setVariable ['BIS_noCoreConversations', true];
					dayz_clientPreload = true;
				};
			///////////////////////////////////////////////////////////
				if((!dayz_townGenerator or {call sched_townGenerator_ready})) then {
					if (_debug) then {diag_log [diag_tickTime,'Preload_Display'];};

					player disableConversation true;

					eh_player_killed = player addeventhandler ["FiredNear",{_this call player_weaponFiredNear;} ];

					//_state = player getVariable["state",[]];
					_currentWpn = "";
					_currentAnim = "";
					if (!isNil '_state' && {count _state > 1} && {_state select 1 != 'reset'}) then {
						//Reload players state
						_currentWpn		=	_state select 0;
						_currentAnim	=	_state select 1;
						//Reload players state
						if (count _state > 2) then {
							dayz_temperatur = _state select 2;
						};
					} else {
						_currentWpn	=	"Makarov";
						_currentAnim	=	"aidlpercmstpsraswpstdnon_player_idlesteady02";
						if (speed player > 0) then {
							//Prevent fresh spawns running on login when they died running, switchMove does not stop it
						
							//disableUserInput true;
							//player playActionNow 'Stop';
							//disableUserInput false;
							//disableUserInput true;
							//disableUserInput false;
							
						};
					};

					reload player;

					if (_currentAnim != "" && !dayz_paraSpawn) then {
						[objNull, player, rSwitchMove,_currentAnim] call RE;
					};

					if (_currentWpn != "") then {
						player selectWeapon _currentWpn;
					} else {
						//Establish default weapon
						if (count weapons player > 0) then
						{
							private['_type', '_muzzles'];

							_type = ((weapons player) select 0);
							// check for multiple muzzles (eg: GL)
							_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");

							if (count _muzzles > 1) then {
								player selectWeapon (_muzzles select 0);
							} else {
								player selectWeapon _type;
							};
						};
					};


					//Player control loop
					dayz_monitor1 = [] spawn {
						while {1 == 1} do { 
							//uiSleep (if (call player_zombieCheck) then {dayz_monitorPeriod/3} else {dayz_monitorPeriod});
							call player_zombieCheck;
							uiSleep 1;
						};
					};
				};

				if (_debug) then {diag_log [diag_tickTime,'Finish'];};

				dayz_playerName = if (alive player) then {name player} else {'unknown'};
				PVDZ_plr_LoginRecord = [_playerUID,_charID,0,toArray dayz_playerName];

				progressLoadingScreen 1;
				endLoadingScreen;

				diag_log format ['Sent to server PVDZ_plr_LoginRecord: [%1, %2, %3, %4]',_playerUID,_charID,0,dayz_playerName]; 

				_world = toUpper(worldName); //toUpper(getText (configFile >> "CfgWorlds" >> (worldName) >> "description"));
				_nearestCity = nearestLocations [getPos player, ["NameCityCapital","NameCity","NameVillage","NameLocal"],1000];

				Dayz_logonTown = "Wilderness";
				if (count _nearestCity > 0) then {Dayz_logonTown = text (_nearestCity select 0)};

				[_world,Dayz_logonTown,format[localize "str_player_06",(floor ((_survival select 0) / 1440))]] spawn {uiSleep 5; _this spawn BIS_fnc_infoText;};

				dayz_myPosition = getPosATL player;
				Dayz_loginCompleted = true;

				//Other Counters
					dayz_currentGlobalAnimals = count entities "CAAnimalBase";
					dayz_currentGlobalZombies = count entities "zZombie_Base";

				{
					call compile preprocessFileLineNumbers ("\z\addons\dayz_code\system\mission\chernarus\infectiousWaterholes\"+_x+".sqf"); 
				} count infectedWaterHoles;
					
				//diag_log (infectedWaterHoles);
			///////////////////////////////////////////////////////////
				if(!isNil 'dayz_preloadFinished' && {dayz_preloadFinished}) then {
					diag_log 'player_forceSave called from fsm';
					sm_done = true;
					//call player_forceSave;

					//Check for bad controls at login
					false spawn ui_updateControls;

					publicVariableServer "PVDZ_plr_LoginRecord";
					PVDZ_plr_LoginRecord spawn dayz_recordLogin;
				};


		{ _x call fnc_veh_ResetEH; } forEach vehicles;
		player allowDamage true;
		player enableSimulation true;
		if (dayz_paraSpawn && freshSpawn == 2) then {[player,DZE_HaloSpawnHeight] spawn BIS_fnc_halo;}; //Start after enableSimulation
		
		
	};
	//Just in case
	//player enableSimulation true;
	//addSwitchableUnit player;
	//setPlayable player;
	//selectPlayer player;
///////////////////////////////////////////////////////////
 
//};


//(findDisplay 46) displayAddEventHandler ["KeyDown","_this call dayz_spaceInterrupt"];