// by ALIAS
// nul = [obj_pozition,duration] execvm "ALfireworks\alias_rock.sqf";

if (!hasInterface) exitWith {};

private ["_al_project_temp","_sunetf","_red","_green","_blue","_poc_sound","_li","_ps1","_lanspark","_lolx","_poc_mic","_bri"];

_al_project_temp= _this select 0;
_sunetf= _this select 1;
_red = _this select 2;
_green = _this select 3;
_blue = _this select 4;
_poc_sound = _this select 5;


	_li = "#lightpoint" createVehicle(getPosATL _al_project_temp);
	_li lightAttachObject [_al_project_temp, [0,0,0.5]];
	_li setLightBrightness 10;
	//_li setLightAttenuation [/*start*/ 10, /*constant*/50, /*linear*/ 50, /*quadratic*/ 2000, /*hardlimitstart*/50,/* hardlimitend*/100]; 
	_li setLightAmbient[1,1,1];
	_li setLightColor[1,1,1];
	
	_ps1 = "#particlesource" createVehicle getPosATL _al_project_temp;
	_ps1 setParticleCircle [0, [0, 0, 0]];
	_ps1 setParticleRandom [2, [0, 0, 0], [0.2, 0.2, 0.5], 0.3, 0.5, [0, 0, 0, 0.5], 0, 0];
	_ps1 setParticleParams ["\ca\data\missilesmoke", "", "Billboard", 1, 0.5+random 1, [0, 0, 0], [0, 0, 0.5], 0, 10.1, 7.9, 0.01, [1, 2, 3], [[0.1,0.1,0.1,0.9], [0.6,0.6,0.6,0.6], [0.8,0.8,0.8,0.4],[0.9,0.9,0.9,0.3],[1,1,1,0.1]], [0.125], 1, 0, "", "", _al_project_temp];
	_ps1 setDropInterval 0.01;
	
	sleep _sunetf;
	_lanspark = "Rabbit" createVehicle (getPosATL _al_project_temp);
	_lanspark setpos [getPosATL _al_project_temp select 0,getPosATL _al_project_temp select 1,getPosATL _al_project_temp select 2];
//	hint str (getPosATL _al_project_temp select 2);	sleep 1;
	deleteVehicle _li;
	deleteVehicle _ps1;
	
	//===================================================================	

	_nr=0;	
	_xx = 0;
	_zz = 0;
	_dire_temp = [[-30,30],[30,30],[-30,-30],[30,-30]];
	_jeton = [];
	
	while {_nr<4} do {
	private ["_splah_al"];
	_splah_al = "#particlesource" createVehicleLocal (getPosATL _lanspark); //	hint str (_dire_temp select _nr);
	_jeton = (_dire_temp select _nr);
	_xx = _jeton select 0;
	_zz = _jeton select 1;
	_splah_al setParticleCircle [0, [_xx, 0, _zz]];
	_splah_al setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0.5, [_red,_green,_blue, 1], 1, 0];
	_splah_al setParticleParams ["\ca\data\missilesmoke", "", "Billboard", 1, 2, [0, 0, 0], [_xx, 0, _zz], 0, 70, 0, 0, [0.5,1], [[_red,_green,_blue, 1],[_red,_green,_blue, 0.5]], [0.08], 1, 0, "", "",_lanspark];
	_splah_al setDropInterval 0.01;			
	_nr=_nr+1;
	[_splah_al] spawn {_ptr_sters=_this select 0; sleep 1; deleteVehicle _ptr_sters};
	sleep 0.001;
	};
	
	// ========================================================================

	_lolx = "#lightpoint" createVehicle(getPosATL _lanspark);
	_lolx lightAttachObject [_lanspark, [0,0,20]];
	_lolx setLightBrightness 100;
	_lolx setLightAmbient[_red,_green,_blue];
	_lolx setLightColor[_red,_green,_blue];	

	_poc_mic = "#particlesource" createVehicle (getPosATL _lanspark);
	_poc_mic setParticleCircle [0, [50, 50, 50]];
	_poc_mic setParticleRandom [0.5, [0, 0, 0], [50, 50, 50], 0, 0.5, [_red,_green,_blue, 1], 1, 0];
	_poc_mic setParticleParams ["\ca\data\missilesmoke", "", "Billboard", 1, 2, [0, 0, 0], [0, 0, 0], 0, 70, 0, 0, [0.5,2], [[_red,_green,_blue, 1],[_red,_green,_blue, 0.5]], [0.08], 1, 0, "", "",_lanspark];
	_poc_mic setDropInterval 0.0005;			
	sleep 0.5;
	deleteVehicle _poc_mic;
	//[nil,_lanspark,rSAY,[_poc_sound, 100]] call RE;
	_lanspark say [_poc_sound,100];
	//_lanspark say3d [_poc_sound,2000];
	
	_bri = 60;	
	while {_bri>0} do {
	_lolx setLightBrightness _bri;
	_bri = _bri-1;
	sleep 0.05;
	};
	
	deleteVehicle _lolx;
	deleteVehicle _lanspark;