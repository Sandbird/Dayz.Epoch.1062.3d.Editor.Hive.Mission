/***************This file is customizable**************
	Required knowledge: Low to moderate
	
	To bind an option to a function key:
	1. Remove the // infront of the key type you want to use
	2. Change DIRECTORY_HERE to the folder the sqf file is saved in (such as tools or skins)
	3. Change FILE_NAME_HERE.sqf to the file name you want to use ex. AdminMode.sqf
	You have now bound an option to that F key!
	
	Some files require special values to be passed to them to work correctly so not ALL actions can be
	configured into this file. If you wish to bind an Admin Mode or Mod Mode option such as god mode
	to these keys you will require more work to make it work correctly.
	
	To change F1-F3 simply change the file name like you did in step 2 above
	To disable the use of a single F key simply comment out the line by add // at the start of the line
	To remove all function key support simply delete or comment out the lines in this file.
*/

// F1_KEY reserved for earplugs toggle
// F2_Key used for hotkey admin tools activation
// F3_KEY reserved for HUD status icons toggle
// F4 is reserved for AdminMode.sqf and modMode.sqf
// F5 is reserved for group manager
// F6 is reserved for spectate.sqf
// F7_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 65) then {[] execVM ""dayz_code\admintools\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};"];
// F8_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 66) then {[] execVM ""dayz_code\admintools\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};"];
// F9_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 67) then {[] execVM ""dayz_code\admintools\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};"];
// F10_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 68) then {[] execVM ""dayz_code\admintools\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};"];
// F11_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 87) then {[] execVM ""dayz_code\admintools\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};"];
// WARNING: F12 is the screen shot key for steam
// F12_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 88 then {[] execVM ""dayz_code\admintools\DIRECTORY_HERE\FILE_NAME_HERE.sqf"";true};"];
Del_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 211) then {[] execVM ""dayz_code\admintools\tools\DatabaseRemove.sqf"";true};"]; // Used to delete target objects
J_Key = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 36) then {[] execVM ""dayz_code\admintools\tools\getObjectDetails.sqf"";true};"]; // Displays cursor target details side chat
L_Key = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 38) then {[] execVM ""dayz_code\admintools\tools\PointtoLock.sqf"";true};"]; // Locks object
U_Key = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 22) then {[] execVM ""dayz_code\admintools\tools\PointtoUnlock.sqf"";true};"]; // Unlocks object

diag_log("Admin Tools: FunctionKeys.sqf Loaded");