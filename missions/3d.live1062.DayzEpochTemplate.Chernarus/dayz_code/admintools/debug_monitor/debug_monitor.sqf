private["_serverTitle","_serverSubtitle","_playerUID","_characterID","_time","_hours","_minutes","_restartTime"];

/************************* CONFIG *************************/

	_serverTitle = "DayZ Hive Mission";
	_serverSubtitle = "v1062"; // DELETE line 40 if you don't want this to show
	_characterID = (player getVariable["CharacterID", 0]);
	_playerUID = (player getVariable["playerUID", 0]);
	
/************************* CONFIG *************************/

if (isNil 'debugMonitor') then {
		debugMonitor = true;
	} else {
		debugMonitor = !debugMonitor;
		hintSilent '';
	};


while {debugMonitor} do {
	
	// Want to change the colors? http://www.w3schools.com/colors/colors_picker.asp
	// Use the #xxxxxx color code you get on that website and place it with any of the
	//<t size..... lines below format: color='#xxxxxx'
	
	// You can delete any of the <t size..... lines that you do not want
	// THE LAST LINE MUST HAVE A ",
	hintSilent parseText format ["
		<t size='1.25' font='Bitstream' align='center' color='#5882FA'>%1</t><br/>
		<t size='1.05' font='Bitstream' align='center' color='#5882FA'>%2</t><br/> 
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'></t><t size='0.95 'font='Bitstream' align='right'></t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Players Online: </t><t size='0.95 'font='Bitstream' align='right'>%3</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Murders: </t><t size='0.95' font='Bitstream' align='right'>%4</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Bandits Killed: </t><t size='0.95' font='Bitstream' align='right'>%5</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Zombies Killed: </t><t size='0.95' font='Bitstream' align='right'>%6</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Humanity: </t><t size='0.95' font='Bitstream' align='right'>%7</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>Blood: </t><t size='0.95' font='Bitstream' align='right'>%8</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'>FPS: </t><t size='0.95' font='Bitstream' align='right'>%9</t><br/>
		<t size='0.95' font='Bitstream' align='left' color='#FFBF00'></t><t size='0.95 'font='Bitstream' align='right'></t><br/>
		<t size='1.15' font='Bitstream'align='center' color='#5882FA'>CharacterID: %10</t><br/>
		<t size='1.15' font='Bitstream'align='center' color='#5882FA'>PUID: %11</t><br/>
		<t size='1.15' font='Bitstream'align='center' color='#5882FA'>Have fun coding!</t><br/>", //ONLY last line needs the ",
			
		_serverTitle, // Used on line 40 for server title
		_serverSubtitle, // Used on line 41 for server subtitle
		(count playableUnits), // Used on line 43 for player count
		(player getVariable['humanKills', 0]), // Used on line 44 for murder count
		(player getVariable['banditKills', 0]), // Used on line 45 for bandit kill count
		(player getVariable['zombieKills', 0]), // Used on line 46 for zombie kill count
		(player getVariable['humanity', 0]), // Used on line 47 for humanity count
		(player getVariable['USEC_BloodQty', r_player_blood]), // Used on line 48 for player blood amount
		(round diag_fps), // Used on line 49 for frames per second
		_characterID,
		_playerUID // Used on line 51 for frames per second
	];
	
	//Don't modify this part
	uiSleep 0.5;
};