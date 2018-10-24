private ["_isHiveOk","_newPlayer","_isInfected","_model","_backpackMagTypes","_backpackMagQty","_backpackWpnTypes","_backpackWpnQtys","_countr","_isOK","_backpackType","_backpackWpn","_backpackWater","_mags","_magsb","_wpns","_bcpk","_bcpkWpn","_config","_playerUID","_msg","_myTime","_charID","_inventory","_backpack","_survival","_isNew","_version","_debug","_lastAte","_lastDrank","_usedFood","_usedWater","_worldspace","_state","_setDir","_setPos","_legs","_arms","_totalMins","_days","_hours","_mins","_messing"];
if(isNil "DZEdebug") then { DZEdebug = false; };
_debug = DZEdebug;
if (_debug) then {
	diag_log ("PSETUP: Initating");
};
progressLoadingScreen 1;
if (isNil "freshSpawn") then {
	freshSpawn = 0;
};

dayz_characterID =	player getVariable ["CharacterID","0"];
_playerUID = player getVariable ["playerUID", 0];
dayz_playerUID 	 = _playerUID;  // Fix...This has to be initiated after it was set

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


//Record current weapon state
dayz_myWeapons = 		weapons player;		//Array of last checked weapons
dayz_myItems = 			items player;		//Array of last checked items
dayz_myMagazines = 	magazines player;
dayz_playerName =		name player;

dayz_myCursorTarget = cursortarget;
dayz_myPosition = 		getPosATL player;	//Last recorded position
dayz_lastMeal =			(3 * 60);
dayz_lastDrink =		(3 * 60);
dayz_zombiesLocal = 	0;			//Used to record how many local zombies being tracked
dayz_Survived = 10;  //total alive dayz
dayz_loginTime = diag_tickTime;

//load in medical details
r_player_dead = 		player getVariable["USEC_isDead",false];
r_player_unconscious = 	player getVariable["NORRN_unconscious", false];
r_player_infected =	player getVariable["USEC_infected",false];
r_player_injured = 	player getVariable["USEC_injured",false];
r_player_inpain = 	player getVariable["USEC_inPain",false];
r_player_cardiac = 	player getVariable["USEC_isCardiac",false];
r_player_lowblood =	player getVariable["USEC_lowBlood",false];
r_player_blood = 		player getVariable["USEC_BloodQty",r_player_bloodTotal];
r_player_timeout = 	player getVariable["unconsciousTime",0];

//Hunger/Thirst
_messing =			player getVariable["messing",[0,0,0]];
dayz_hunger = 	_messing select 0;
dayz_thirst = 		_messing select 1;
dayz_nutrition  = 	_messing select 2;

//Create a dayz_authkey
//////////////////////////////////////////////
_randomKey = [];
_clientID = owner player;
_randomInput = toArray "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$^*";
for "_i" from 0 to 12 do {
	_randomKey set [count _randomKey, (_randomInput call BIS_fnc_selectRandom)];
};
_randomKey = toString _randomKey;
_findIndex = dayz_serverPUIDArray find _playerUID;
if (_findIndex > -1) then {
	dayz_serverClientKeys set [_findIndex, [_clientID,_randomKey]];
} else {
	dayz_serverPUIDArray set [(count dayz_serverPUIDArray), _playerUID];
	dayz_serverClientKeys set [(count dayz_serverClientKeys), [_clientID,_randomKey]];
};
dayz_authkey = _randomKey;
//////////////////////////////////////////////


//Initial State of player
dayz_loadScreenMsg =  "Character Data received";
diag_log("-------------Character Data received-------------");