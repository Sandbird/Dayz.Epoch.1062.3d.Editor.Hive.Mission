// ===========================================================================
// extDB3 author: Bryan "Tonic" Boardwine
// extDB3 source: https://bitbucket.org/torndeco/extdb3/src
// extDB3 licence: https://bitbucket.org/torndeco/extdb3/wiki/Home
// ! Read licence information !
// ---------------------------------------------------------------------------
// :: Package is prepared for shared mode > multiple addon authors using extDB3
// :: This package distribution is for testing only - still WIP (but fully working - improvements will come)
// :: Ported for DayzEpoch 1.0.6.2+ by @iben
// :: last update [2017-11-23]
// ===========================================================================

// ---------------------------------------------------------------------------
// ===========================================================================
// :: Package is prepared for shared mode > multiple addon authors using extDB3
// :: This package distribution is for testing only - still WIP (but fully working - improvements will come)
// :: Ported for DayzEpoch 1.0.6.2+ by @iben
// :: last update [2017-11-23]
// ===========================================================================

// ---------------------------------------------------------------------------
// :: Function lib identification
#define MODULENAME "EXTDB"

// ---------------------------------------------------------------------------
// :: extDB codename
#define EXTDB "extDB3"

// ---------------------------------------------------------------------------
// :: Bad chars for strip. Why?
//    > SQL friendly code
//    > SQL safe code (SQL injections - client side inputs i.e. player name:
//      we will not force admins to setup BEC config (player name restriction)
//    > To convert char just use > diag_log format ["%1",(toArray(yourBadChar))];
//    > Bellow definition is: '/\`:|;,{}-""<>
// :: Important: has to be ARRAY!
#define BADCHARSTOSTRIP [60,62,38,123,125,91,93,59,58,39,96,126,44,46,47,63,124,92,34]

// ---------------------------------------------------------------------------
// :: Common strings
#define FATALSTR "FATAL ERROR"

// ---------------------------------------------------------------------------
// :: Debug logging
// :: There are 3 main debug log types:
// :: (1) '__EXTDBGEN__' >> enable/disable in this file (bellow). If enabled,
//        you can see general log in RPT file
// :: (2) '__EXTDBINT__'   >> enable/disable inside 'helpers\EXTDB_fnc_callDebugLog'.
//        If enabled, you can see general log in RPT file + on user display screen
// :: NOTE_1: Do not define these macros inside functions! Leave this job for global
//            'EXTDB_fnc_callDebugLog' function. This way you can generally toggle
//            your 'log to RPT' or 'log on screen' option from one place,
//            instead of each fnc separately.
// :: (3) '__ROOTDBG__' >> enable/disable in this file (bellow). If enabled,
//        you can see autodiscovered addon root path in RPT file
// ***************************************************************************
#define __EXTDBGEN__
#define __ROOTDBG__
// ***************************************************************************

// ---------------------------------------------------------------------------
// :: Common formatting patterns
#define FSTR1(ST,p1) (format [ST,p1])
#define FSTR2(ST,p1,p2) (format [ST,p1,p2])
#define FSTR3(ST,p1,p2,p3) (format [ST,p1,p2,p3])
#define FSTR4(ST,p1,p2,p3,p4) (format [ST,p1,p2,p3,p4])
#define FSTR5(ST,p1,p2,p3,p4,p5) (format [ST,p1,p2,p3,p4,p5])
#define FSTR6(ST,p1,p2,p3,p4,p5,p6) (format [ST,p1,p2,p3,p4,p5,p6])

// ---------------------------------------------------------------------------
// :: Debug msg format
//    >> CALLER : File making call
//    >> SRC    : Source script processing call
#define DBG(CALLER,SRC,MSG) diag_log format ["=== [%1, [%2]] || DEBUG :: [%3] >> %4",MODULENAME,CALLER,SRC,MSG]
#define DBS(CALLER,SRC,MSG) systemChat format ["=== [%1, [%2]] || DEBUG :: [%3] >> %4",MODULENAME,CALLER,SRC,MSG]


// ---------------------------------------------------------------------------
private ["_callType","_protocol","_querySTR"];
_callType = (_this select 0);
_protocol = (_this select 1);
_querySTR = (_this select 2);

private "_paramCheck";
_paramCheck = [
   ("EXTDB_fnc_APICall")
  ,[(count _this),3]
  ,[_callType,_protocol,_querySTR]
  ,["SCALAR","STRING","STRING"]
] call EXTDB_fnc_paramCheck;

if !(_paramCheck) exitWith { /* Check RPT log */ };

// ---------------------------------------------------------------------------
private "_key";
_key = EXTDB callExtension format ["%1:%2:%3",_callType,_protocol,_querySTR];

// ---------------------------------------------------------------------------
// :: Exit if we do not expect any return from query
if (_callType == 1) exitWith {true;};

// ---------------------------------------------------------------------------
_key = call compile format ["%1",_key];
_key = (_key select 1);

uiSleep (random .03);
// ---------------------------------------------------------------------------
// :: Retreive single / multipart msg [4,5] - watch wait status [3]
private ["_queryRe","_loop","_pipe","_null","_return"];
_queryRe = "";
_loop = true;

while {_loop} do {
  _queryRe = EXTDB callExtension format ["4:%1",_key];
  if (_queryRe == "[5]") then {
    _queryRe = "";
    while {1 == 1} do {
      _pipe = EXTDB callExtension format ["5:%1",_key];
      if (_pipe == "") exitWith {_loop = false;};
      _queryRe = _queryRe + _pipe;
    };
  } else {
    if (_queryRe == "[3]") then {
      uiSleep .1;
    } else {
      _loop = false;
    };
  };
};

// ---------------------------------------------------------------------------
_queryRe = call compile _queryRe;

// ---------------------------------------------------------------------------
// :: extDB error check > inform if somenthing goes wrong
if ((_queryRe select 0) == 0) exitWith {
  _null = [
     "SYSTEM","EXTDB_fnc_APICall"
    ,format ["Cannot process your API call. Reason > Protocol [%1] ERROR! > %2",_protocol,_queryRe]
  ] call EXTDB_fnc_callDebugLog;
  []
};

// ---------------------------------------------------------------------------
// :: Output
diag_log("EXTDB_fnc_APICall----------loaded");
_return = (_queryRe select 1);
_return
