private ["_myGuy"];
_myGuy = _this select 0;
_myGuy setIdentity "Bot1_player";  // Check description.ext
_myGuy setVariable ["USEC_BloodQty",5000,true];
_myGuy setVariable ["CharacterID", "222222", true];
_myGuy setVariable ["playerUID", "222222", true];
_myGuy setVariable ["friendlies", ["111111"], true];  //friend to me
_myGuy disableAI "MOVE";

 
/*
while {alive _myGuy} do {	

	
	sleep 1;
};
*/