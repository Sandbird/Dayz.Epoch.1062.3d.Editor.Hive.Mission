// ===========================================================================
// :: Package is prepared for shared mode > multiple addon authors using extDB3
// :: This package distribution is for testing only - still WIP (but fully working - improvements will come)
// :: Ported for DayzEpoch 1.0.6.2+ by @iben
// :: last update [2017-11-23]
// ===========================================================================

// ---------------------------------------------------------------------------
// :: EXTDB root path autofinder: Do not remove it!
// #include "core\helpers\EXTDB_fnc_init_ROOTer.sqf"
//EXTDBROOT = ["EXTDB_init",__FILE__,true,false] call EXTDB_fnc_init_ROOTer;
//if (isNil "EXTDBROOT") exitWith { /* See RPT log */ };

// ---------------------------------------------------------------------------
// :: Compile patterns
//#define CPP(HAN) HAN = compile preprocessFileLineNumbers format ["%1\core\helpers\%2.sqf",EXTDBROOT,#HAN]
//#define CCP(FOL,FIL) call compile preprocessFileLineNumbers format ["%1\%2\%3.sqf",EXTDBROOT,#FOL,#FIL]


EXTDB_fnc_callDebugLog = compile preprocessFileLineNumbers "dayz_server\extDB\core\helpers\EXTDB_fnc_callDebugLog.sqf";
EXTDB_fnc_paramCheck = 	compile preprocessFileLineNumbers "dayz_server\extDB\core\helpers\EXTDB_fnc_paramCheck.sqf";
EXTDB_fnc_callEXTLog = 	compile preprocessFileLineNumbers "dayz_server\extDB\core\helpers\EXTDB_fnc_callEXTLog.sqf";
EXTDB_fnc_getLocalTime = 	compile preprocessFileLineNumbers "dayz_server\extDB\core\helpers\EXTDB_fnc_getLocalTime.sqf";
EXTDB_fnc_sanitize = 	compile preprocessFileLineNumbers "dayz_server\extDB\core\helpers\EXTDB_fnc_sanitize.sqf";
EXTDB_fnc_APICall = 	compile preprocessFileLineNumbers "dayz_server\extDB\core\helpers\EXTDB_fnc_APICall.sqf";
EXTDB_connect = 	compile preprocessFileLineNumbers "dayz_server\extDB\core\EXTDB_connect.sqf";
EXTDB_postConnect = 	compile preprocessFileLineNumbers "dayz_server\extDB\core\EXTDB_postConnect.sqf";

/*
// ---------------------------------------------------------------------------
// :: Compile helper functions
CPP(EXTDB_fnc_callDebugLog); // RPT (+ onscreen log in debug mode)
CPP(EXTDB_fnc_paramCheck);
CPP(EXTDB_fnc_callEXTLog);   // extDB separate log (custom logfile)
CPP(EXTDB_fnc_getLocalTime);
CPP(EXTDB_fnc_sanitize);
CPP(EXTDB_fnc_APICall);

// ---------------------------------------------------------------------------
// :: Fire connection procedure
CCP(core,EXTDB_connect);

// ---------------------------------------------------------------------------
// :: Fire stored MySQL callable procedures
CCP(core,EXTDB_postConnect);
*/