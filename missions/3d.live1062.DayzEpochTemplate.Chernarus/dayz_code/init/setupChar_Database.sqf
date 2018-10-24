private ["_isHiveOk","_newPlayer","_isInfected","_model","_backpackMagTypes","_backpackMagQty","_backpackWpnTypes","_backpackWpnQtys","_countr","_isOK","_backpackType","_backpackWpn","_backpackWater","_playerUID","_msg","_myTime","_charID","_inventory","_backpack","_survival","_isNew","_version","_debug","_lastAte","_lastDrank","_usedFood","_usedWater","_worldspace","_state","_setDir","_setPos","_legs","_arms","_totalMins","_days","_hours","_mins","_messing","_myLoc","_id","_nul","_world","_nearestCity","_first","_AuthAttempt","_timeStart","_readytoAuth","_startCheck","_myEpochAnim","_myEpoch","_myEpochB","_myEpochSfx","_myEpochDayZ","_zombies"];

if(isNil "DZEdebug") then { DZEdebug = false; };
_debug = DZEdebug;
if (_debug) then {
	diag_log ("PSETUP: Initating");
};
//LOGIN INFORMATION
_playerName = name player;
if (_playerName == '__SERVER__') exitWith {};

_playerUID = player getVariable ["playerUID", 0];
dayz_playerUID 	 = _playerUID;  // Fix...This has to be initiated after it was set

//diag_log ("PSETUP playerID Player [" + _playerUID + "]");
_msg = [];
dayz_versionNo = getText(configFile >> "CfgMods" >> "DayZ" >> "version");
diag_log ("DAYZ: CLIENT IS RUNNING DAYZ_CODE " + str(dayz_versionNo));
_AuthAttempt = 0;
0 fadeSound 0;
progressLoadingScreen 0.1;
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
//////////////////////////////////////////////////////////
endLoadingScreen;
if (_debug) then {
diag_log ("PLOGIN: Initating");
};
dayz_loadScreenMsg = (localize "str_player_loading"); 
progressLoadingScreen 0.2;
if (_debug) then {diag_log [diag_tickTime,'Loading'];};

_myAssets = getText(configFile >> "CfgPatches" >> "dayz_communityassets" >> "dayzVersion");
_mySfx = getNumber(configFile >> "CfgPatches" >> "dayz_sfx" >> "dayzVersion");
_myAnim = getNumber(configFile >> "CfgPatches" >> "dayz_anim" >> "dayzVersion");
_myEpoch = getText(configFile >> "CfgPatches" >> "dayz_epoch" >> "dayzVersion");
_myEpochB = getText(configFile >> "CfgPatches" >> "dayz_epoch_b" >> "dayzVersion");
if (_debug) then {
	diag_log format["DayZ Version: DayZ_Anim: %1 DayZ_SFX: %2 DayZ_Assets: %3",_myAnim, _mySfx,_myAssets];
};

player enableSimulation true;
///////////////////////////////////////////////////////////
if (!isNull player) then {
	if (_debug) then {
	diag_log ("PLOGIN: Player Ready");
	};
	dayz_loadScreenMsg = localize 'str_player_waiting_creation'; 
	_playerUID = dayz_playerUID;// _playerUID = player getVariable ["playerUID", "0"];
	progressLoadingScreen 0.6;
};

if !(isNil "_playerUID") then {
	_myTime = diag_tickTime;
	dayz_loadScreenMsg = ("Waiting for server to start authentication");
	if (_debug) then {
		diag_log ("Server Loading");
		diag_log ("PLOGIN: Waiting for server to start authentication");
		};
		progressLoadingScreen 0.5;
};

	if (_debug) then {
		diag_log ("PLOGIN: Requesting Authentication... (" + _playerUID + ")");
	};
	dayz_loadScreenMsg = localize 'str_player_request';
	progressLoadingScreen 0.65;
	
	_msg = [];
	PVCDZ_plr_Login = [];
	PVDZ_plr_Login1 = [_playerUID,player];
	publicVariable "PVDZ_plr_Login1";
	[_playerUID,player] call server_playerLogin;   	diag_log ['Sent to server: PVDZ_plr_Login1', PVDZ_plr_Login1]; 

	PVDZ_send = [player,"dayzSetDate",[player]];
	publicVariable "PVDZ_send";
	[player,"dayzSetDate",[player]] call server_sendToClient;
	diag_log ['Sent to server: PVDZ_send', PVDZ_send]; 
	
	_myTime = diag_tickTime;
	if(count (PVCDZ_plr_Login) > 1) then {
		_msg = PVCDZ_plr_Login;
		diag_log format[">>>>>>>>> Got the login data: %1",_msg];
	};

	dayz_authed = true;

//Logged ?

	if (_debug) then {diag_log [diag_tickTime,'Parse_Login'];};
	progressLoadingScreen 0.8;
	_charID		= str(_msg select 0);
	_inventory	= _msg select 1;
	_backpack	= _msg select 2;
	_survival 	= _msg select 3;
	_isNew 		= _msg select 4;
	_state 		= _msg select 5;
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
	if (_isHiveOk) then { if (!_schedulerStarted) then { _schedulerStarted=true; execVM '\z\addons\dayz_code\system\scheduler\sched_init.sqf'; }; };
	if (_debug) then {
		diag_log ("PLOGIN: authenticated with : " + str(_msg));
		diag_log ["player_monitor:Parse_Login _isHiveOk,_isNew,isnil preload, preload:",_isHiveOk,_isNew,!isNil 'dayz_preloadFinished',dayz_preloadFinished];
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



	if (_debug) then {diag_log [diag_tickTime,'Phase_One'];};
	if ((!isNil "dayz_selectGender") && {(!isNil "DZE_defaultSkin") && (_isInfected == 0)}) then {
		if (dayz_selectGender == "Survivor2_DZ") then {
			_rand = (DZE_defaultSkin select 0) call BIS_fnc_selectRandom;
			_model = getText (configFile >> "CfgMagazines" >> "Skins" >> _rand >> "playerModel"); //MALE
			if (_model == "") then {
					_model = _rand;
			};
		} else {
			_rand = (DZE_defaultSkin select 1) call BIS_fnc_selectRandom;
			_model = getText (configFile >> "CfgMagazines" >> "Skins" >> _rand >> "playerModel"); //FEMALE
			if (_model == "") then {
					_model = _rand;
			};
		};
	};

	dayz_playerName = name player;
	_weapons = weapons player;
	//diag_log("WEAPONS"+str(_weapons));
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
	gear_done = true;
	
	PVCDZ_plr_Login2 = [];
	PVDZ_plr_Login2 = [_charID,player,_inventory];
	publicVariable "PVDZ_plr_Login2";
	[_charID,player,_inventory] spawn server_playerSetup;
	diag_log ['Sent to server: PVDZ_plr_Login2', PVDZ_plr_Login2]; 
	dayz_loadScreenMsg = localize 'str_player_requesting_character';
	
	if (_debug) then {
		diag_log "Attempting Phase two...";
	};
	
	if(count (PVCDZ_plr_Login2) > 0) then {
						_msg = player getVariable["worldspace",[]];
						dayz_loadScreenMsg = localize 'str_player_requesting_character';

						if (_debug) then {
							diag_log "####PVCDZ_plr_Login2 true";
							diag_log "Finished...";
						};
						dayz_loadScreenMsg = localize 'str_login_characterData'; 

						_worldspace = 	PVCDZ_plr_Login2 select 0;
						_state =			PVCDZ_plr_Login2 select 1;
						dayz_authKey = PVCDZ_plr_Login2 select 2;

						player setVariable ["Achievements",[],false];

						_setDir = 			_worldspace select 0;
						_setPos = 			_worldspace select 1;

						if (isNil "freshSpawn") then {
							freshSpawn = 0;
						};

						{
							if (player getVariable["hit_"+_x,false]) then { 
								[player,_x] spawn fnc_usec_damageBleed; 
								PVDZ_hlt_Bleed = [player,_x];
								publicVariable "PVDZ_hlt_Bleed"; // draw blood stream on character, on all gameclients
								[player,_x] call fnc_usec_damageBleed;
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

						dayz_playerUID = _playerUID;

						if ((_isNew) OR (count _inventory == 0)) then {
							//player is new, add initial loadout
							if !(player isKindOf "PZombie_VB") then {
								_config = (configFile >> "CfgSurvival" >> "Inventory" >> "Default");
								_totalrndmags = getNumber (_config >> "RandomMagazines");
								_rndmags = getArray (_config >> "RandomPossibilitieMagazines");
								_countmags = 0; 
								_gmags = getArray (_config >> "GuaranteedMagazines");
								_wpns = getArray (_config >> "weapons");
								_bcpk = getText (_config >> "backpack");
								_bcpkWpn = getText (_config >> "backpackWeapon");
								if(!isNil "DefaultMagazines") then {
									_gmags = DefaultMagazines;
								};
								if(!isNil "DefaultWeapons") then {
									_wpns = DefaultWeapons;
								};
								if(!isNil "DefaultBackpack") then {
									_bcpk = DefaultBackpack;
								};
								if(!isNil "DefaultBackpackItems") then {
									_bcpkWpn = DefaultBackpackItems;
								};
							
								//Add inventory
								{
									_isOK = 	isClass(configFile >> "CfgMagazines" >> _x);
									if (_isOK) then {
										player addMagazine _x;
										_countmags = _countmags  +1;
									};
								} count _gmags;

								while {_countmags < _totalrndmags} do {
									_rndmag = _rndmags call BIS_fnc_selectRandom;
									_isOK = 	isClass(configFile >> "CfgMagazines" >> _rndmag);
									if (_isOK) then {
										player addMagazine _rndmag;
										_countmags = _countmags  +1;
									};
								};

								{
									_isOK = 	isClass(configFile >> "CfgWeapons" >> _x);
									if (_isOK) then {
										player addWeapon _x;
									};
								} count _wpns;
							
								if (_bcpk != "") then {
								player addBackpack _bcpk; 
								dayz_myBackpack =	unitBackpack player;

									if ((typeName _bcpkWpn) == "ARRAY") then {
										{
											if (isClass(configFile >> "CfgWeapons" >> _x)) then {
												dayz_myBackpack addWeaponCargoGlobal [_x,1];
											} else {
												dayz_myBackpack addMagazineCargoGlobal [_x, 1];
											};
										} count _bcpkWpn;
									} else {
										if (_bcpkWpn != "") then {
											dayz_myBackpack addWeaponCargoGlobal [_bcpkWpn, 1];
										};
									};
								};
							};
						};

						//Work out survival time
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

						//Hunger/Thirst
						_messing =			player getVariable["messing",[0,0,0]];
						dayz_hunger = 	_messing select 0;
						dayz_thirst = 		_messing select 1;
						dayz_nutrition  = 	_messing select 2;

						//player setVariable ["humanity",-3000, true];
						///////////////////////////////////////////////////

					if(!r_player_dead/* and !_isNew*/) then{
						if (_debug) then {diag_log [diag_tickTime,'Position'];};
						progressLoadingScreen 0.85;
					};

					if(_version == dayz_versionNo) then{
						if (_debug) then {diag_log [diag_tickTime,'Date_or_Time_Send'];};
						_myTime = diag_tickTime;
					};

					if(!isNil "dayzSetDate") then{
						if (_debug) then {diag_log [diag_tickTime,'Stream'];};
						dayz_loadScreenMsg = localize 'str_login_spawningLocalObjects';
					};

					if(((!dayz_townGenerator or (!isNil 'dayz_plantSpawner_done' && {dayz_plantSpawner_done == 2})) && (!isNil 'BIS_fnc_init'))) then{
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

					if((!dayz_townGenerator or {call sched_townGenerator_ready})) then{
							
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
								/*
								disableUserInput true;
								player playActionNow 'Stop';
								disableUserInput false;
								disableUserInput true;
								*/
								disableUserInput false;
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

					if(preloadCamera getPosATL player) then{
						if (_debug) then {diag_log [diag_tickTime,'Initialize'];};

						//Medical
						dayz_medicalH = [] execVM "\z\addons\dayz_code\medical\init_medical.sqf";	//Medical Monitor Script (client only)
						[player] call fnc_usec_damageHandle;

						if (r_player_unconscious) then {
							player playActionNow "Die";
							[player,r_player_timeout] call fnc_usec_damageUnconscious;
						};

						//Add core tools
						player addWeapon "Loot";
						if ((currentWeapon player == "")) then { player action ["SWITCHWEAPON", player,player,1]; };
						//load in medical details
						r_player_dead = 		player getVariable["USEC_isDead",false];
						r_player_unconscious = 	player getVariable["NORRN_unconscious", false];
						r_player_infected =		player getVariable["USEC_infected",false];
						r_player_injured = 		player getVariable["USEC_injured",false];
						r_player_inpain = 		player getVariable["USEC_inPain",false];
						r_player_cardiac = 		player getVariable["USEC_isCardiac",false];
						r_player_lowblood =		player getVariable["USEC_lowBlood",false];
						r_player_blood = 		player getVariable["USEC_BloodQty",r_player_bloodTotal];
						r_player_bloodtype = player getVariable ["blood_type", false];
						r_player_rh = player getVariable ["rh_factor", false];

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

						{ _x call fnc_veh_ResetEH; } forEach vehicles;
						player allowDamage true;
						player enableSimulation true;
						if (dayz_paraSpawn && freshSpawn == 2) then {[player,DZE_HaloSpawnHeight] spawn BIS_fnc_halo;}; //Start after enableSimulation	
					};

					//Finish
					if (_debug) then {diag_log [diag_tickTime,'Finish'];};

					dayz_playerName = if (alive player) then {name player} else {'unknown'};
					PVDZ_plr_LoginRecord = [_playerUID,_charID,0,toArray dayz_playerName];


					progressLoadingScreen 1;

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
						
					diag_log (infectedWaterHoles);

					if(!isNil 'dayz_preloadFinished' && {dayz_preloadFinished}) then{
						diag_log 'player_forceSave called from fsm';
						//call player_forceSave;

						//Check for bad controls at login
						false spawn ui_updateControls;

						publicVariable "PVDZ_plr_LoginRecord";
						if (DefaultTruePreMadeFalse) then {
							//////////////////[_playerUID,_charID,0,toArray dayz_playerName] call dayz_recordLogin;  Was like this in 10.62 
							PVDZ_plr_LoginRecord spawn dayz_recordLogin;	
						};
					};

	};