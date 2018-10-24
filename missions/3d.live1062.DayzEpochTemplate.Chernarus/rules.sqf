private ["_messages","_timeout"];

_messages = [
	["DayZ Epoch", "Welcome "+(name player)],
	["Instructions 1", "Edit variables.sqf and add your playerUID"],
	["Instructions 2", "Edit init.sqf and change DefaultTruePreMadeFalse to true to load your DB character"],
	["Instructions 3", "Change the values for MarkerP based on your mission.sqm file (used for Hive spawning random stuff on start)"],
	["Instructions 4", "Dont forget to add your database name as well in DB_NAME."],
	["Important", 	 "Dont forget getPlayerUID doesnt work inside the editor!"],
	["World", worldName],
	["Rules", "No talking in side. (hahahaha)"]
];
 
_timeout = 5;
{
	private ["_title","_content","_titleText"];
	uiSleep 2;
	_title = _x select 0;
	_content = _x select 1;
	_titleText = format[("<t font='TahomaB' size='0.40' color='#a81e13' align='right' shadow='1' shadowColor='#000000'>%1</t><br /><t shadow='1'shadowColor='#000000' font='TahomaB' size='0.60' color='#FFFFFF' align='right'>%2</t>"), _title, _content];
	[
		_titleText,
		[safezoneX + safezoneW - 0.8,0.50],     //DEFAULT: 0.5,0.35
		[safezoneY + safezoneH - 0.8,0.7],      //DEFAULT: 0.8,0.7
		_timeout,
		0.5
	] spawn BIS_fnc_dynamicText;
	uiSleep (_timeout * 1.1);
} forEach _messages;