private ["_characterID","_playerObj","_spawnSelection","_inventory","_playerID","_dummy","_worldspace","_state","_doLoop","_key","_primary","_spawnMC","_medical","_stats","_humanity","_randomSpot","_position","_distance","_fractures","_score","_findSpot","_mkr","_j","_isIsland","_w","_clientID","_lastInstance"];
//diag_log ("STARTING PLAYER SETUP: " + str(_this));
diag_log(".......................SETUP Player........................");
_characterID = _this select 0;
_playerObj = _this select 1;
//_spawnSelection = _this select 3;
_inventory = _this select 2;
_playerID = _playerObj getVariable ["playerUID", "0"];
///////////////////////////////////////////////////////////
//#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"
//diag_log format ["Server_playerSetup, got: CharID:%1, PlayerObj:%2, Inv: %3, _playerID :%4", _characterID, _playerObj, _inventory, _playerID];


if (isNull _playerObj) exitWith {
	diag_log ("SETUP INIT FAILED: Exiting, player object null: " + str(_playerObj));
};

if (_playerID == "") then {
	_playerID = _playerObj getVariable ["playerUID", "0"];
};

if (_playerID == "") exitWith {
	diag_log ("SETUP INIT FAILED: Exiting, no player ID: " + str(_playerObj));
};

private "_dummy";
_dummy = _playerObj getVariable ["playerUID", "0"];
if (_playerID != _dummy) then { 
	diag_log format["DEBUG: _playerID miscompare with UID! _playerID:%1",_playerID]; 
	_playerID = _dummy;
};

_worldspace = [];
_state = [];

//Do Connection Attempt
_doLoop = 0;
while {_doLoop < 5} do {
	//_key = format["CHILD:102:%1:",_characterID];
	//_primary = [format["SELECT Worldspace, Medical, Generation, KillsZ, HeadshotsZ, KillsH, KillsB, CurrentState, Humanity, InstanceID, Coins FROM Character_DATA WHERE CharacterID='%1'",_characterID],2,false] call extDB_async_2;
	//_primary = _primary select 0;
	
	_key = format["SELECT Worldspace, Medical, Generation, KillsZ, HeadshotsZ, KillsH, KillsB, CurrentState, Humanity, InstanceID, Coins FROM character_data WHERE CharacterID='%1'",_characterID];
	_response = _key call server_hiveReadWriteLarge;
	//diag_log format["::::::: 1- Before compile ::::: %1",_response];
	_response = [_response, '"[', '['] call KRON_Replace;
	_response = [_response, ']"', ']'] call KRON_Replace;
	_response = call compile _response;
	//diag_log format["::::::: 2- After compile ::::: %1",_response];
	_primary = _response select 1 select 0;
	//diag_log format ["extDB3: _primary: %1", _primary];
	if (count _primary > 0) then {
		_doLoop = 9;
	};
	_doLoop = _doLoop + 1;
};
//;

if (isNull _playerObj or !isPlayer _playerObj) exitWith {
	diag_log ("SETUP RESULT: Exiting, player object null: " + str(_playerObj));
};

//Wait for HIVE to be free
//diag_log ("SETUP: RESULT: Successful with " + str(_primary));
//[[144,[6270.12,7903.54,0.002]],[false,false,false,false,false,false,false,12000,[],[0,0],0,"O",true,[19.286,11.915,0],false],3,0,0,0,0,[["M9_SD_DZ","aidlpknlmstpsraswpstdnon_player_idlesteady01",42],[]],2500,11,0]
_medical = _primary select 1;
_worldspace = _primary select 0;
_humanity = _primary select 8;
_lastInstance =	_primary select 6;
_statearray = if (count _primary >= 4) then {_primary select 7} else {[""]};
_stats = [];
_stats = call compile format["[%1,%2,%3,%4]", (_primary select 3),(_primary select 4),(_primary select 5),(_primary select 6)];
_state =	_primary select 8;

//_stats = _primary select 2;
_randomSpot = false; //Set position

if (count _statearray == 0) then {_statearray = [""];}; //diag_log ("StateNew: "+str(_statearray));
if (typeName ((_statearray) select 0) == "STRING") then {_statearray = [_statearray,[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]];};
_state = (_statearray) select 0; //diag_log ("State: "+str(_state));

_Achievements = (_statearray) select 1;
if (count _Achievements == 0) then {_Achievements = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];};
//diag_log ("Achievements: "+str(_Achievements));
//diag_log ("WORLDSPACE: " + str(_worldspace));

if (count _worldspace > 0) then {
	_position = _worldspace select 1;
	if (count _position < 3) exitWith {_randomSpot = true;}; //prevent debug world!
	
	_distance = respawn_west_original distance _position;
	if (_distance < 2000) then {_randomSpot = true;};
	
	_distance = [0,0,0] distance _position;
	if (_distance < 500) then {_randomSpot = true;};
	//_playerObj setPosATL _position;
	
	// Came from another server force random spawn
	if (_lastInstance != dayZ_instance) then {_randomSpot = true;};
} else {
	_randomSpot = true;
};

//diag_log ("LOGIN: Location: " + str(_worldspace) + " doRnd?: " + str(_randomSpot));

//set medical values
if (count _medical > 0) then {
	_playerObj setVariable ["USEC_isDead",(_medical select 0),true];
	_playerObj setVariable ["NORRN_unconscious",(_medical select 1),true];
	_playerObj setVariable ["USEC_infected",(_medical select 2),true];
	_playerObj setVariable ["USEC_injured",(_medical select 3),true];
	_playerObj setVariable ["USEC_inPain",(_medical select 4),true];
	_playerObj setVariable ["USEC_isCardiac",(_medical select 5),true];
	_playerObj setVariable ["USEC_lowBlood",(_medical select 6),true];
	_playerObj setVariable ["USEC_BloodQty",(_medical select 7),true];

	//Add bleeding wounds
	{
		_playerObj setVariable ["hit_"+_x,true,true];
	} forEach (_medical select 8);

	//Add fractures
	_fractures = _medical select 9;
	_playerObj setVariable ["hit_legs",(_fractures select 0),true];
	_playerObj setVariable ["hit_hands",(_fractures select 1),true];
	_playerObj setVariable ["unconsciousTime",(_medical select 10),true];
	_playerObj setVariable ["messing",if (count _medical >= 14) then {(_medical select 13)} else {[0,0,0]},true];
	_playerObj setVariable ["blood_testdone",if (count _medical >= 15) then {(_medical select 14)} else {false},true];
	if (count _medical > 12 && {typeName (_medical select 11) == "STRING"}) then { //Old character had no "messing" OR "messing" in place of blood_type
		_playerObj setVariable ["blood_type",(_medical select 11),true];
		_playerObj setVariable ["rh_factor",(_medical select 12),true];
//		diag_log [ "Character data: blood_type,rh_factor,testdone=",
//			_playerObj getVariable ["blood_type", "?"],_playerObj getVariable ["rh_factor", "?"], _playerObj getVariable ["blood_testdone", false]
//		];
	} else {
		_playerObj call player_bloodCalc;
		diag_log [ "Character upgrade to 1.8.3: blood_type,rh_factor=",_playerObj getVariable ["blood_type", "?"],_playerObj getVariable ["rh_factor", "?"]];
	};
} else {
	//Reset bleeding wounds
	call fnc_usec_resetWoundPoints;
	//Reset fractures
	_playerObj setVariable ["hit_legs",0,true];
	_playerObj setVariable ["hit_hands",0,true];
	_playerObj setVariable ["USEC_injured",false,true];
	_playerObj setVariable ["USEC_inPain",false,true];
	_playerObj call player_bloodCalc; // will set blood_type and rh_factor according to real population statitics
	//diag_log [ "New character setup: blood_type,rh_factor=",_playerObj getVariable ["blood_type", "?"],_playerObj getVariable ["rh_factor", "?"]];
	_playerObj setVariable ["messing",[0,0,0],true];
	_playerObj setVariable ["blood_testdone",false,true];
};

if (count _stats > 0) then {
		//register stats Global
	_playerObj setVariable["zombieKills",(_stats select 0),true];
	_playerObj setVariable["headShots",(_stats select 1),true];
	_playerObj setVariable["humanKills",(_stats select 2),true];
	_playerObj setVariable["banditKills",(_stats select 3),true];
		
		//ConfirmedKills
		_playerObj setVariable ["ConfirmedHumanKills",(_stats select 2),true];
		_playerObj setVariable ["ConfirmedBanditKills",(_stats select 3),true];
		
	_playerObj addScore (_stats select 1);
		
		//Save Score
		_score = score _playerObj;
		_playerObj addScore ((_stats select 0) - _score);

		missionNamespace setVariable [_playerID,[_humanity,(_stats select 0),(_stats select 1),(_stats select 2),(_stats select 3)]];
	} else {
		//register stats
		_playerObj setVariable ["zombieKills",0,true];
		_playerObj setVariable ["humanKills",0,true];
		_playerObj setVariable ["banditKills",0,true];
		_playerObj setVariable ["headShots",0,true];
		
		//ConfirmedKills
		_playerObj setVariable ["ConfirmedHumanKills",0,true];
		_playerObj setVariable ["ConfirmedBanditKills",0,true];

		missionNamespace setVariable [_playerID,[_humanity,0,0,0,0]];
	};
/*

if (_randomSpot) then {
	private ["_counter","_position","_isNear","_isZero","_mkr"];
	if (!isDedicated) then {endLoadingScreen;};
	
		//Spawn modify via mission init.sqf
		if(isnil "spawnArea") then {
			spawnArea = 1500;
		};
		if(isnil "spawnShoremode") then {
			spawnShoremode = 1;
		};
		
		// 
		_spawnMC = actualSpawnMarkerCount;
	
	
	_IslandMap = (toLower worldName in ["caribou","cmr_ovaron","dayznogova","dingor","dzhg","fallujah","fapovo","fdf_isle1_a","isladuala","lingor","mbg_celle2","namalsk","napf","oring","panthera2","ruegen","sara","sauerland","smd_sahrani_a2","tasmania2010","tavi","trinity","utes"]);

	//spawn into random
	_findSpot = true;
	_mkr = [];
	_position = [0,0,0];
	for [{_j=0},{_j<=100 && _findSpot},{_j=_j+1}] do {
		//if (_spawnSelection == 9) then {
			// random spawn location selected, lets get the marker and spawn in somewhere
		//	if (dayz_spawnselection == 1) then {_mkr = getMarkerPos ("spawn" + str(floor(random 6)));} else {_mkr = getMarkerPos ("spawn" + str(floor(random actualSpawnMarkerCount)));};
		//} else {
			// spawn is not random, lets spawn in our location that was selected
			//_mkr = getMarkerPos ("spawn" + str(_spawnSelection));
			_mkr = "spawn" + str(floor(random _spawnMC));
		//};
		//_position = ([_mkr,0,spawnArea,10,0,2,spawnShoremode] call BIS_fnc_findSafePos);
		_position = ([(getMarkerPos _mkr),0,spawnArea,10,0,2000,spawnShoremode] call BIS_fnc_findSafePos);
		if ((count _position >= 2) // !bad returned position
			&& {(_position distance _mkr < spawnArea)}) then { // !ouside the disk
			_position set [2, 0];
			if (((ATLtoASL _position) select 2 > 2.5) //! player's feet too wet
			&& {({alive _x} count (_position nearEntities ["CAManBase",150]) == 0)}) then { // !too close from other players/zombies
				_pos = +(_position);
				_isIsland = false; //Can be set to true during the Check
				// we check over a 809-meter cross line, with an effective interlaced step of 5 meters
				for [{_w = 0}, {_w != 809}, {_w = ((_w + 17) % 811)}] do {
					//if (_w < 17) then { diag_log format[ "%1 loop starts with _w=%2", __FILE__, _w]; };
					_pos = [((_pos select 0) - _w),((_pos select 1) + _w),(_pos select 2)];
					if ((surfaceisWater _pos) && !_IslandMap) exitWith {_isIsland = true;};
				};
				if (!_isIsland) then {_findSpot = false};
			};
		};
		//diag_log format["%1: pos:%2 _findSpot:%3", __FILE__, _position, _findSpot];
	};
	if (_findSpot && !_IslandMap) exitWith {
		diag_log format["%1: Error, failed to find a suitable spawn spot for player. area:%2",__FILE__, _mkr];
	};
	_worldspace = [0,_position];
	
	//Fresh spawn, clear animationState so anim from last sync does not play on login
	_state = ["","reset"];
};

*/

//record player pos locally for server checking
_playerObj setVariable ["characterID",_characterID,true];
_playerObj setVariable ["playerUID",_playerID,true];
_playerObj setVariable ["humanity",_humanity,true];
_playerObj setVariable ["lastPos",getPosATL _playerObj];

_clientID = owner _playerObj;
_randomKey = [];
_randomInput = toArray "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!@#$^*";
for "_i" from 0 to 12 do {
	_randomKey set [count _randomKey, (_randomInput call BIS_fnc_selectRandom)];
};
_randomKey = toString _randomKey;
_findIndex = dayz_serverPUIDArray find _playerID;
if (_findIndex > -1) then {
	dayz_serverClientKeys set [_findIndex, [_clientID,_randomKey]];
} else {
	dayz_serverPUIDArray set [(count dayz_serverPUIDArray), _playerID];
	dayz_serverClientKeys set [(count dayz_serverClientKeys), [_clientID,_randomKey]];
};

PVCDZ_plr_Login2 = [_worldspace,_state,_randomKey];
_clientID publicVariableClient "PVCDZ_plr_Login2";
if (dayz_townGenerator) then {
	_clientID publicVariableClient "PVCDZ_plr_plantSpawner";
};

if (isNil "dayzSetDate") then {
	call sched_sync;
};
_clientID publicVariableClient "dayzSetDate";
setDate LIVE_DATE;

//record time started
_playerObj setVariable ["lastTime",diag_ticktime];

//set server-side inventory variable to monitor player gear
if (count _inventory > 2) then {
	_playerObj setVariable["ServerMagArray",[_inventory select 1,_inventory select 2], false];
};

//Record Player Login/LogOut
[_playerID,_characterID,1,(_playerObj call fa_plr2str),((_worldspace select 1) call fa_coor2str)] call dayz_recordLogin;

PVDZ_plr_Login1 = nil;
PVDZ_plr_Login2 = nil;
BIS_fnc_init = true;