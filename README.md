# Dayz.Epoch.1062.3d.Editor.Live.Mission with Database interaction

[![ScreenShot](http://oi58.tinypic.com/2s0fde8.jpg)](http://youtu.be/e4DKLVoBQgA)

A custom mission file for the purpose of testing/writing scripts for [DayZ Epoch](https://github.com/vbawol/DayZ-Epoch) without the need of a server.
It emulates the dayz_server and dayz_mission files, so you can write scripts using the 3d editor. No need to use a dayz_server for debugging anymore. We all know how time consuming that is.

## Features:
  - Database integration (yes thats right... [:)]
  - I would suggest to have a maximum of 100 objects in your object_data table for faster results. Took 5min to load 10000 objs from my real database, so also make sure you dont go crazy with the ***MaxVehicleLimit***, ***MaxDynamicDebris*** values in the init.sqf
- Fully working GUI, zombies, hit registration, addactions, everything!
- Write code and execute it on the fly. No need to start a server and join with a client to test things.
- 100% of your scripts will work! (dynamic weather, default loadouts, custom scripts etc)
- 2 setups. A default 3d editor player with a default loadout or a Real database character based on your UID
- Includes most of BIS_fnc functions, so actions like BIS_fn_invAdd will work (i've added most common ones...more included though...check details bellow.)
- Everything works...when i say everything i mean EVERYTHING !. (Spawning objects on mission start, traders (buy/sell), maintenance, character update, events, stats...etc)

## New Features!

  - All .FSM files have been converted to .SQF meaning the mission acts as a full fledged server / client merge. New character creation has been ignored though, so the server excepts that the client that is about to connect exists in the database. The server will start, wait for a 'fake client connection to happen' (you pressing the Preview button), and then it will load your character from the database, spawn Hive objects and create new based on your MaxVehicleLimit values etc, then initialize the events and finally spawn the character to his worldspace location.
  - Use [AdminTools](https://epochmod.com/forum/topic/44863-release-epoch-admin-tools-v-1107-test-branch/) to spawn any Perm, Temp vehicle you want, including buildings, crates etc
  - Building objects is working as expected with a little ***AddAction*** trick. Unfortunately the primary display (eg: findDisplay 46) isnt working inside the editor. That means that building stuff or placing objects is very hard to do since we cant 'capture' keystrokes. Further details below after the Installation instructions.
  - Arma2Net is not allowed by Battleye anymore, so i am using extDB3 now.
 
## Requirements:

- A MySQL server on the same machine as your Arma2 editor. Well...a remote PC would work as well...just make sure YOU ARE NOT using your original database. Make a copy of it!. This mission will interact with your database !
If you dont have a mysql server on your pc...i suggest you get [WampServer](http://www.wampserver.com/en/). Its the easiest php/mysql server out there.

## Installation

- Download the file and extract it in a folder.
- Copy the ***"3d.live1062.DayzEpochTemplate.Chernarus"*** mission file to your ***\My Documents\ArmA 2\missions\*** folder. 
    - If your active Arma profile is not the default one, then you probably should extract it in the ***\My Documents\ArmA 2 Other Profiles 2\missions\*** folder, otherwise you wont be able to find the mission inside the editor.
- Copy everything inside ***"Arma2OA root folder"*** into your root Arma2OA folder.
  - The ***real_date.dll***...Thanks to [killzonekid](http://killzonekid.com/arma-extension-real_date-dll-v3-0) is used to get your machine's date/time to be used for live day/night cycles inside the game, as well as ticktime functions in dayz_server (...you can set a fixed day if you want...details bellow)
  - The ***tbbmalloc - tbbmalloc_x64.dll*** files are provided by [extDB3](https://github.com/AirwavesMan/extDB). They shouldnt interfere with your normal game, but they are needed for the mission to be able to connect to your MySQL server. (Make a backup of your original ones if you want, just be safe.)
  - ***EATbaseExporter*** is used by the AdminTools, and allows you to export bases to an .sqf format so you can import them afterwards to your server.
- Now edit ***-=START HIVE MISSION=-.bat*** which was placed in your Arma2 folder, and fix the paths to their proper values. If you are using DZLauncher then the @Dayz_Epoch folder is probably where i placed it myself. 
    - Battleye needs to be disabled inside the editor otherwise the extDB3 addon will not work. The .bat is taking care of that. It will disable Battleye after 7 seconds. Depending on your machine, if you see that the time isnt sufficient, raise that value a little bit. 
- A sample Database has been provided with me as a character and a basic loadout. You can of course use your own database, just remember to delete most of your Object_Data table vehicles. The more vehicles you have there, the longer it will take for the dayz_server to spawn them. If you just want to write a script independent of cars etc...why wait 5 minutes for the server to spawn 10000 vehicles :)
- Open ***"ArmaOA\@extDB\extdb3-conf.ini"*** and add your test database data there. I named the test SQL DB ***dayz_cherno***
Example:
```sh
[dayz_cherno]
IP = localhost
Port = 3306
Username = dayz
Password = mypass123
Database = dayz_cherno

# dayz_cherno is the name of the database (change it in both values)
# localhost   is your mysql server (could be an IP value as well)
# 3306        your mysql port
# dayz        is your database username
# mypass123   is your database password
```
- When the game launches, press Alt+E, select Chernarus, then Load mission ***3d.live1062.DayzEpochTemplate.Chernarus***
- Open ***\My Documents\ArmA 2\missions\3d.live1062.DayzEpochTemplate.Chernarus\init.sqf***
  - Go to line ***61*** and start editing the values there. ***DB_NAME*** is the name of your database (same as the extdb3 config file).
  - Add your ***PlayerUID*** value (same as the DB one) in line ***72***.
  - Depending which map you want to use, you have to change the ***dayZ_instance*** variable and also the ***MarkerP*** values (line 62) based on your mission.sqm file. Its for the Hive to spawn random vehicles, roadblocks and mines at proper locations based on the map.

### Default setup vs Database setup
There are 2 ways of initializing your player.
1. A live database player based on his UID in the character_data table (coordinates, medical states, inventory etc)
2. A default 3d editor player with a basic loadout. (Ignores Hive Loadouts and initial vehicle spawns)

### Database Setup (extDB3)
- ***[DefaultTruePreMadeFalse = true;]***
- This option is now the default one, because its so much easier to set up, plus a lot of things have changed in the 1062 Epoch version. I couldnt totally separate the server files from the client files, so in the end a Database is necessary for the Mission files to work properly.
To setup your character with this method, leave ***DefaultTruePreMadeFalse*** to ***true***; 
Everything is database based..so no need to do anything else. The mission will start with all your stats, inventory, conditions and spawn you where your world coordinates are.

### Premade Character Setup
- ***[DefaultTruePreMadeFalse = false;]***
This setup DOES NOT initialize the character based on a database entry, or does any HIVE related queries on mission start. (like load objects etc). Instead it uses some premade stats that you set, and only uses the Database on updates (buy vehicles etc)
The loadout of the player is set in the init.sqf in line ***77***
```sh
player setVariable ["CharacterID", "1", true];		// Set here the characterID of the player. It can be anything...just leave it 1 if you want.
player setVariable ["playerUID", "111111", true]; // Set here the playerUID of the player you want to have.
player setVariable["Z_globalVariable", 100000];
player setVariable["Z_BankVariable", 100000];
player setVariable["Z_MoneyVariable", 100000];
player setVariable["humanity", 11000];
player setVariable["humanKills", 10];
player setVariable["banditKills", 20];
player setVariable["zombieKills", 30];
player setVariable ["friendlies", ["222222","333333"], true]; //Both DZE_Friends and this must be set for friendlies to work properly
DZE_Friends = ["222222","333333"];
```
- Everything else should work fine with the database....like traders, salvaging, etc...
Unfortunately since the 1062 ver had many differences from the 1051 one, i couldn't really make this Profile option a standalone one, without any Database interaction. So in order for you to minimize any errors in the log file, i would suggest you load my sample db file provided, and also change those CharacterID and PlayerUID values in PLAYER_Data and CHARACTER_Data tables to the ones you set up here, just in case....
- The Premade character setup is for people that want to fast debug a script they are making and dont want to wait for the Hive to load all map objects and authenticate the player first.

## Further Details to change (in both Profile Cases)
The ***description.ext***, ***mission.sqf***, ***mission.biedi*** files have your character's name in them. Just search for the word ***Sandbird*** in all of them and change it according to the PlayerName value you have in your ***Player_DATA*** table for your PlayerUID value.
Example taken from description.ext
~~~~
	class My_Player
	{
		name="Sandbird";
		face="Face20";
		glasses="None";
		speaker="Male01EN";
		pitch=1.1;
	};
~~~~

## Important info

### Init.sqf values
- ***StaticDayOrDynamic = true;***    // A static date is set at the bottom of \dayz_server\init\server_function.sqf.  Set this to false if you want real time/date inside the mission.
- ***DZEdebug = false;***             // Set to true if you want a more detailed log file
- ***Enable Keyboard actions (menu option)*** // (findDisplay 46) wont work inside the editor. That means that building stuff or placing objects is very hard to do since we cant 'capture' keystrokes. I kinda fixed this with a trick. In order to build something first you have to initiate the building action (holding the object in your hands) and then scroll with your mouse wheel and select Enable Keyboard actions. This will create a layer on your screen capturing your keystrokes thus allowing you to change orientations etc. Pressing ESC twice after and it will close the fake display and return to normal play mode. You will have to do this every time you want to build something.

### Related to coding
- Since the Editor has some limitations because its not a real server some things will never work. For example:
***_playerUID = getPlayerUID player;*** will never work in the editor. 
To get the _playerUID you have to do this: ***_playerUID = player getVariable ["PlayerUID",0];***
This is the most important thing to remember. Lots of scripts use ***getPlayerUID***. You have to remember to change it every time you want to use it. Of course the ***player*** value is just an example here. If you were inside a loop and it had (getPlayerUID _x) then you have to rewrite it like this: (_x getVariable["PlayerUID",0])

- ***findDisplay 46*** does not work in the editor. If you are using/making a script that uses Display 46 try using my ***Enable Keyboard*** action. It might work in your case.

- ***publicvariableServer*** commands dont exist in the editor. There is no server to accept the command. If you want to use addpublicvariableeventhandler you can do it with call/spawn commands. You can find the handlers usually in the PublicEH.sqf.
Example:
~~~~ 
PVDZE_plr_Save = [player,dayz_Magazines,false,true];
publicVariableServer "PVDZE_plr_Save";
~~~~ 
can be written like:
~~~~ 
PVDZE_plr_Save = [player,dayz_Magazines,false,true];
// keeping this so when you move the code to the real server you remember to add it.
publicVariableServer "PVDZE_plr_Save"; 
[player,dayz_Magazines,false,true] spawn server_playerSync;  
// what to call is usually inside publicEH.sqf. In this case search for PVDZE_plr_Save in the PublicEH file and check the call it makes in the end.
~~~~ 
- You could also change the ***publicVariableServer*** to ***publicVariable***. That should work inside the editor. But keep in mind these changes wont work on the live server, since one command broadcasts something to the server while the other just to the client running it. I would suggest you keep the original value and do the PublicEH call instead, marking it down with some debug comments next to it, so when you are done and want to transfer the files to your live server you just remove the call and everything should work as expected.

- Dont forget to change the paths when you are adding addons to test/modify them. For example, notice the differences here:
~~~~ 
player_switchModel = compile preprocessFileLineNumbers "dayz_code\compile\player_switchModel.sqf";
player_checkStealth = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_checkStealth.sqf";
~~~~
- The first line will look up for player_switchModel.sqf inside the mission files, while the 2nd one will go to the @Dayz_Epoch map file and get the .sqf file. Same thing applies for the dayz_server files (server_functions.sqf). Once you are done with your script and you have added new compile lines, you need to fix them back to their proper values before you upload them to your live server.

- If you are missing any BIS_fnc functions then check the folder ***dayz_code\system\functions*** and see if it's available there to include it in the compiles.sqf.

- Set ***DZEdebug = true;***  in the init.sqf. And ALWAYS check your RPT log file for debugging. Its located in : %AppData%\Local\ArmA 2 OA folder


### Related to mission file included
- You'll notice when you start the mission there are 2 bots standing there. If you double click the soldier you'll see that he initiates this script scripts\BotInit.sqf. I left that in purpose in case you want to do some scripting that requires 'another player', and you want to initialize the fake player like that. The other bot can be deleted. I just left it there because i was testing a Tag Friendly script, and needed a 3rd 'player' that has me as a friend.
- I've included a simple Fireworks script i made a while back only this time i used some better effects taken from [aliascartoons](http://www.armaholic.com/page.php?id=30846&highlight=FIREWORKS) work. Just add a 'SMAW_HEDP' into your inventory and right click on it to test it out. Here is how the old script used to look like [Fireworks](https://youtu.be/jEo_BCMxpcw).
- Also you'll find a little 'hat script' in the files, just right click a 'IRStrobe' item to add a hat to your player.
- Both script were written inside the editor using the mission file above...just a small example to show you how easy it is to write code there.
- The @extDB folder contains a folder called ***debug_files***. These .dlls (when replaced the ones provided) activate a more detailed log file (found under ***arma 2 operation arrowhead\logs*** folder). It will show ALL MySQL queries going in/out of the database. Very useful if you are running any custom SQL queries and the RTP log file isnt enough.


## Final Notes
These are heavily modified files...Dont overwrite them with your own files. Add to them instead of replacing them.
If you are writing scripts that dont require the server to restart, then you can just go to 2D editor and press Preview again after you make the changes. No need to hit Restart. As long as you are doing changes that doesnt affect the Hive loading you can basically run things on the fly. For example in the init.sqf at the bottom i added a ***Add BankMonkey*** example. That command just loads the ***custom\money.sqf*** and shows a simple extDB3 example on how to select/update a DB table. Since this command doesnt require the server to restart, you can just hit Preview, test things out, and if you want to make changes, go back to 2D Editor, edit your changes and hit Preview again. No need to hit Restart and wait for the dayz_server functions to do their thing again.
The whole purpose of this project was to not waste any more time trying to code on this god forsaken Arma engine.

And a personal note....You will NEVER find an easier way to code stuff for Dayz....period. This is the fastest way to write code and see it in action. 

Hope this code will help you write code faster and easier :)


### Credits

This mission file would not be possible without the help of these addons/people

| Mod | README |
| ------ | ------ |
| DayzEpochTeam | http://epochmod.com |
| killzonekid | http://killzonekid.com/ |
| extDB3 | https://bitbucket.org/torndeco/extdb3/wiki/Home |


