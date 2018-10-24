private["_EXECgenTools","_EXECweapons","_EXECbackpacks","_EXECgear","_EXECcrates","_EXECadminBuild","_EXECbuildings","_EXECskins","_EXECdate","_EXECcloud","_EXECfog"];

_EXECgenTools = 'player execVM "dayz_code\admintools\tools\%1"';
_EXECweapons = '["%1","%2","%3"] execVM "dayz_code\admintools\weaponkits\WeaponKits.sqf"';
_EXECbackpacks = '["%1"] execVM "dayz_code\admintools\weaponkits\BackPack.sqf"';
_EXECgear = 'player execVM "dayz_code\admintools\weaponkits\%1"';
_EXECcrates = '["%1"] execVM "dayz_code\admintools\crates\spawnCrate.sqf"';
_EXECadminBuild = '["%1",false,true] execVM "dayz_code\admintools\tools\AdminBuild\adminBuild.sqf"';
_EXECbuildings = 'player execVM "dayz_code\admintools\tools\AdminBuild\%1"';
_EXECskins = '["%1"] execVM "dayz_code\admintools\tools\skinChanger.sqf"';
_EXECdate = 'EAT_PVEH_SetDate = [%1,%2,%3,%4,0]; setDate EAT_PVEH_SetDate; publicVariable "EAT_PVEH_SetDate"';
_EXECcloud = 'EAT_PVEH_SetOvercast = %1; 5 setOvercast EAT_PVEH_SetOvercast; publicVariable "EAT_PVEH_SetOvercast"';
_EXECfog = 'EAT_PVEH_SetFog = %1; 5 setFog EAT_PVEH_SetFog; publicVariable "EAT_PVEH_SetFog"';


// Main menu
if(isNil "EAT_mainMenu") then {

	EAT_mainMenu = [["",true],["-- Epoch Admin Tools (Level: Admin) --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_mainMenu = EAT_mainMenu + [["Admin Menu >>", [], "#USER:EAT_adminMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_mainMenu = EAT_mainMenu + [["Vehicle Menu >>",[],"#USER:EAT_vehicleMenu",-5,[["expression",""]],"1","1"]];
	EAT_mainMenu = EAT_mainMenu + [["Crate Menu >>",[],"#USER:EAT_crateMenu",-5,[["expression",""]],"1","1"]];
	EAT_mainMenu = EAT_mainMenu + [["Epoch Menu >>", [], "#USER:EAT_epochMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_mainMenu = EAT_mainMenu + [["Weapon/Item Kits >>", [], "#USER:EAT_weaponMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_mainMenu = EAT_mainMenu + [["Teleport Menu >>",[],"#USER:EAT_teleportMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_mainMenu = EAT_mainMenu + [["Skin Change Menu >>", [], "#USER:EAT_skinMenu", -5, [["expression", ""]], "1", "1"]];
	if(EAT_wtChanger)then{EAT_mainMenu = EAT_mainMenu + [["Weather/Time Menu >>", [], "#USER:EAT_weatherTimeMenu", -5, [["expression", ""]], "1", "1"]];};
	if(EAT_ActionMenuPlayers && EAT_AllowContactAdmin)then{EAT_mainMenu = EAT_mainMenu + [["Player Ticket Menu >>", [], "", -5, [["expression", format[_EXECgenTools,"contactAdminTickets.sqf"]]], "1", "1"]];};
	EAT_mainMenu = EAT_mainMenu + [["", [], "", -5, [["expression", ""]], "1", "0"], ["Exit", [20], "", -5, [["expression", ""]], "1", "1"]];


// Admin only menu
	EAT_adminMenu = [["",true]];
	EAT_adminMenu = EAT_adminMenu + [["-- Administrator's Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_adminMenu = EAT_adminMenu + [["Admin Mode (F4 for options)",[],"", -5,[["expression",format[_EXECgenTools,"AdminMode\adminMode.sqf"]]],"1","1"]];
	EAT_adminMenu = EAT_adminMenu + [["Point to Repair",[],"", -5,[["expression", format[_EXECgenTools,"PointToRepairPERM.sqf"]]], "1", "1"]];
	EAT_adminMenu = EAT_adminMenu + [["Point to Delete",[],"", -5,[["expression",format[_EXECgenTools,"DatabaseRemove.sqf"]]],"1","1"]];
	EAT_adminMenu = EAT_adminMenu + [["Spectate player (F6 to cancel)",[],"", -5,[["expression", format[_EXECgenTools,"spectate.sqf"]]], "1", "1"]];
	EAT_adminMenu = EAT_adminMenu + [["Safe Zone Create/Delete",[],"", -5, [["expression", format[_EXECgenTools,"SafeZoneArea.sqf"]]], "1", "1"]];
	EAT_adminMenu = EAT_adminMenu + [["Zombie Shield",[],"", -5,[["expression",format[_EXECgenTools,"zombieshield.sqf"]]],"1","1"]];
	EAT_adminMenu = EAT_adminMenu + [["Zombie Spawner", [], "", -5, [["expression", format[_EXECgenTools,"zombieSpawn.sqf"]]], "1", "1"]];
	EAT_adminMenu = EAT_adminMenu + [["AI spawner", [], "", -5, [["expression", format[_EXECgenTools,"aiSpawn.sqf"]]], "1", "1"]];
	EAT_adminMenu = EAT_adminMenu + [["Heal Players",[],"", -5, [["expression", format[_EXECgenTools,"healp.sqf"]]], "1", "1"]];
	EAT_adminMenu = EAT_adminMenu + [["Send Server Message",[],"", -5,[["expression",format[_EXECgenTools,"messageDialog.sqf"]]],"1","1"]];
	EAT_adminMenu = EAT_adminMenu + [["Humanity Menu >>",[],"#USER:EAT_humanityMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_adminMenu = EAT_adminMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_adminMenu = EAT_adminMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// Mod only menu
	EAT_modMenu = [["",true]];
	EAT_modMenu = EAT_modMenu + [["-- Moderator's Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_modMenu = EAT_modMenu + [["Mod Mode (F4 for options)",[],"", -5,[["expression",format[_EXECgenTools,"AdminMode\modMode.sqf"]]],"1","1"]];
	EAT_modMenu = EAT_modMenu + [["Point to Repair",[],"", -5,[["expression", format[_EXECgenTools,"PointToRepairPERM.sqf"]]], "1", "1"]];
	EAT_modMenu = EAT_modMenu + [["Point to Delete",[],"",-5,[["expression",format[_EXECgenTools,"DatabaseRemove.sqf"]]],"1","1"]];
	EAT_modMenu = EAT_modMenu + [["Spectate player (F6 to cancel)",[],"", -5,[["expression", format[_EXECgenTools,"spectate.sqf"]]], "1", "1"]];
	EAT_modMenu = EAT_modMenu + [["Heal Players",[],"",-5,[["expression", format[_EXECgenTools,"healp.sqf"]]], "1", "1"]];
	EAT_modMenu = EAT_modMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_modMenu = EAT_modMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// Main vehicle selection menu
	EAT_vehicleMenu = [["",true]];
	EAT_vehicleMenu = EAT_vehicleMenu + [["-- Vehicle Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_vehicleMenu = EAT_vehicleMenu + [["Graphical Vehicle Menu", [],"", -5, [["expression", format[_EXECgenTools,"addvehicleDialog.sqf"]]], "1", "1"]];
	EAT_vehicleMenu = EAT_vehicleMenu + [["Eject Players", [],"", -5, [["expression", format[_EXECgenTools,"ejectPlayers.sqf"]]], "1", "1"]];
	EAT_vehicleMenu = EAT_vehicleMenu + [["Vehicle Tools >>", [], "#USER:EAT_vehicleTools", -5, [["expression", ""]], "1", "1"]];
	EAT_vehicleMenu = EAT_vehicleMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_vehicleMenu = EAT_vehicleMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// Different tools for working with vehicles
	EAT_vehicleTools = [["",true]];
	EAT_vehicleTools = EAT_vehicleTools + [["-- Vehicle Tools --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_vehicleTools = EAT_vehicleTools + [["Vehicle Locator",[],"",-5,[["expression", format[_EXECgenTools,"vehicleLocator.sqf"]]], "1", "1"]];
	EAT_vehicleTools = EAT_vehicleTools + [["Recover Vehicle Key",[],"",-5,[["expression", format[_EXECgenTools,"keyRecovery.sqf"]]], "1", "1"]];
	EAT_vehicleTools = EAT_vehicleTools + [["Point to Repair", [],"", -5, [["expression", format[_EXECgenTools,"PointToRepairPERM.sqf"]]], "1", "1"]];
	EAT_vehicleTools = EAT_vehicleTools + [["Point to Delete",[],"",-5,[["expression",format[_EXECgenTools,"DatabaseRemove.sqf"]]],"1","1"]];
	EAT_vehicleTools = EAT_vehicleTools + [["Flip Vehicle", [],"", -5, [["expression", format[_EXECgenTools,"flipVehicle.sqf"]]], "1", "1"]];
	EAT_vehicleTools = EAT_vehicleTools + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_vehicleTools = EAT_vehicleTools + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

//Main menu to handle humanity changing
	EAT_humanityMenu = [["",true]];
	EAT_humanityMenu = EAT_humanityMenu + [["-- Humanity Change Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_humanityMenu = EAT_humanityMenu + [["Add to self or target", [],"", -5, [["expression", '["add"] execVM "dayz_code\admintools\tools\humanityChanger.sqf"']], "1", "1"]];
	EAT_humanityMenu = EAT_humanityMenu + [["Remove from self or target", [],"", -5, [["expression", '["remove"] execVM "dayz_code\admintools\tools\humanityChanger.sqf"']], "1", "1"]];
	EAT_humanityMenu = EAT_humanityMenu + [["Reset to 2500", [],"", -5, [["expression", '["reset"] execVM "dayz_code\admintools\tools\humanityChanger.sqf"']], "1", "1"]];
	EAT_humanityMenu = EAT_humanityMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_humanityMenu = EAT_humanityMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// Menu for teleport options
	//	teleport to place Example: ["Name",[],"", -5, [["expression", '[x,y,z] execVM "dayz_code\admintools\tools\Teleport\teleportToLocation.sqf"']], "1", "1"]];
	EAT_teleportMenu = [["",true]];
	EAT_teleportMenu = EAT_teleportMenu + [["-- Teleport Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_teleportMenu = EAT_teleportMenu + [["Teleport (4 Key)",[],"", -5,[["expression", format[_EXECgenTools,"Teleport\Teleport.sqf"]]], "1", "1"]];
	EAT_teleportMenu = EAT_teleportMenu + [["Teleport To Me (5 Key)",[],"", -5, [["expression", format[_EXECgenTools, "Teleport\TPtoME.sqf"]]], "1", "1"]];
	EAT_teleportMenu = EAT_teleportMenu + [["Teleport To Player (6 Key)",[],"", -5, [["expression", format[_EXECgenTools, "Teleport\TpToPlayer.sqf"]]], "1", "1"]];
//	EAT_teleportMenu = EAT_teleportMenu + [["Return Player to Last Pos",[],"", -5, [["expression", format[_EXECgenTools, "Teleport\returnPlayerTP.sqf"]]], "1", "1"]];
	EAT_teleportMenu = EAT_teleportMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_teleportMenu = EAT_teleportMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// Menu for changing skins.
// Entry Format:["Entry Name",[],"",-5,[["expression",'["Skin_class_name"] execVM "dayz_code\admintools\tools\skinChanger.sqf"']],"1","1"]];
	EAT_skinMenu = [["",true]];
	EAT_skinMenu = EAT_skinMenu + [["-- Skin Menu (Page 1)", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_skinMenu = EAT_skinMenu + [["Survivor",[],"",-5,[["expression",format[_EXECskins,"Survivor2_DZ"]]],"1","1"]];
	EAT_skinMenu = EAT_skinMenu + [["Hero",[],"",-5,[["expression",format[_EXECskins,"Survivor3_DZ"]]],"1","1"]];
	EAT_skinMenu = EAT_skinMenu + [["Bandit",[],"",-5,[["expression",format[_EXECskins,"Bandit1_DZ"]]],"1","1"]];
	EAT_skinMenu = EAT_skinMenu + [["Soldier",[],"",-5,[["expression",format[_EXECskins,"Soldier1_DZ"]]],"1","1"]];
	EAT_skinMenu = EAT_skinMenu + [["Ghillie",[],"",-5,[["expression",format[_EXECskins,"Sniper1_DZ"]]],"1","1"]];
	EAT_skinMenu = EAT_skinMenu + [["Special Forces",[],"",-5,[["expression",format[_EXECskins,"CZ_Special_Forces_GL_DES_EP1_DZ"]]],"1","1"]];
	EAT_skinMenu = EAT_skinMenu + [["Pilot",[],"",-5,[["expression",format[_EXECskins,"Pilot_EP1_DZ"]]],"1","1"]];
	EAT_skinMenu = EAT_skinMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_skinMenu = EAT_skinMenu + [["Next page >", [], "#USER:EAT_skinMenu2", -5, [["expression", ""]], "1", "1"]];

// Menu2 for changing skins.
	EAT_skinMenu2 = [["",true]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["-- Skin Menu (Page 2)", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["Camo",[],"",-5,[["expression",format[_EXECskins,"Camo1_DZ"]]],"1","1"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["Bodyguard",[],"",-5,[["expression",format[_EXECskins,"Soldier_Bodyguard_AA12_PMC_DZ"]]],"1","1"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["Officer",[],"",-5,[["expression",format[_EXECskins,"Rocket_DZ"]]],"1","1"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["Alejandria",[],"",-5,[["expression",format[_EXECskins,"SurvivorWcombat_DZ"]]],"1","1"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["Savannah",[],"",-5,[["expression",format[_EXECskins,"SurvivorWdesert_DZ"]]],"1","1"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["Melly",[],"",-5,[["expression",format[_EXECskins,"SurvivorWpink_DZ"]]],"1","1"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["Bandit Jane",[],"",-5,[["expression",format[_EXECskins,"BanditW2_DZ"]]],"1","1"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["Invisible",[],"",-5,[["expression",format[_EXECskins,"Survivor1_DZ"]]],"1","1"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_skinMenu2 = EAT_skinMenu2 + [["< Back", [], "#USER:EAT_skinMenu", -5, [["expression", ""]], "1", "1"]];

// Weapon menu select
	EAT_weaponMenu = [["",true]];
	EAT_weaponMenu = EAT_weaponMenu + [["-- Weapons Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_weaponMenu = EAT_weaponMenu + [["Primary Weapons Menu >>",[],"#USER:EAT_primaryWeaponMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_weaponMenu = EAT_weaponMenu + [["Secondary Weapons Menu >>",[],"#USER:EAT_secondaryWeaponMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_weaponMenu = EAT_weaponMenu + [["Gear/Items Menu >>",[],"#USER:EAT_gearMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_weaponMenu = EAT_weaponMenu + [["Delete all gear", [],"", -5, [["expression", format[_EXECgear,"removeGear.sqf"]]], "1", "1"]];
	EAT_weaponMenu = EAT_weaponMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_weaponMenu = EAT_weaponMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

	// Main weapons like the M4
	// Entry Format:["Name", [],"", -5, [["expression", format[_EXECweapons,"Gun_Calss_Name","Ammo_Class_Name","Explosive_Round_Class_Name"]]], "1", "1"]];
	// If there is no explosive 203 round then put "nil" in place of "Explosive_Round_Class_Name" 
	EAT_primaryWeaponMenu = [["",true]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["-- Primary Weapons --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["M4 Holo", [],"", -5, [["expression", format[_EXECweapons,"M4A1_HWS_GL_camo","30Rnd_556x45_Stanag","1Rnd_HE_M203"]]], "1", "1"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["M4A1_DZ GL SD Camo", [],"", -5, [["expression", format[_EXECweapons,"M4A1_HWS_GL_SD_Camo","30Rnd_556x45_StanagSD","1Rnd_HE_M203"]]], "1", "1"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["Sa58V ACOG", [],"", -5, [["expression", format[_EXECweapons,"Sa58V_RCO_EP1","30Rnd_762x39_SA58","nil"]]], "1", "1"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["AKM Kobra", [],"", -5, [["expression", format[_EXECweapons,"AKM_Kobra_DZ","30Rnd_762x39_AK47","nil"]]], "1", "1"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["FN FAL", [],"", -5, [["expression", format[_EXECweapons,"FNFAL_CCO_DZ","20Rnd_762x51_FNFAL","nil"]]], "1", "1"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["Mk 48", [],"", -5, [["expression", format[_EXECweapons,"Mk48_CCO_DZ","100Rnd_762x51_M240","nil"]]], "1", "1"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["AS50", [],"", -5, [["expression", format[_EXECweapons,"BAF_AS50_scoped","5Rnd_127x99_AS50","nil"]]], "1", "1"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [[".338 LAPUA", [],"", -5, [["expression", format[_EXECweapons,"BAF_LRR_scoped","5Rnd_86x70_L115A1","nil"]]], "1", "1"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["DMR_DZ", [],"", -5, [["expression", format[_EXECweapons,"DMR_DZ","20Rnd_762x51_DMR","nil"]]], "1", "1"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_primaryWeaponMenu = EAT_primaryWeaponMenu + [["Secondary Weapons", [], "#USER:EAT_secondaryWeaponMenu", -5, [["expression", ""]], "1", "1"]];

// Sidearm weapons like the Makarov
	EAT_secondaryWeaponMenu = [["",true]];
	EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["-- Secondary Weapons --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["PDW SD", [],"", -5, [["expression", format[_EXECweapons,"UZI_SD_EP1","30Rnd_9x19_UZI_SD"]]], "1", "1"]];
	EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["PDW", [],"", -5, [["expression", format[_EXECweapons,"PDW_DZ","30Rnd_9x19_UZI"]]], "1", "1"]];
	EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["Glock", [],"", -5, [["expression", format[_EXECweapons,"G17_FL_DZ","17Rnd_9x19_glock17"]]], "1", "1"]];
	EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["M9_DZ SD", [],"", -5, [["expression", format[_EXECweapons,"M9_SD_DZ","15Rnd_9x19_M9SD"]]], "1", "1"]];
	EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["Makarov_DZ", [],"", -5, [["expression", format[_EXECweapons,"Makarov_DZ","8Rnd_9x18_Makarov"]]], "1", "1"]];
	EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["Makarov_DZ SD", [],"", -5, [["expression", format[_EXECweapons,"Makarov_SD_DZ","8Rnd_9x18_Makarov"]]], "1", "1"]];
	EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_secondaryWeaponMenu = EAT_secondaryWeaponMenu + [["Gear/Items", [], "#USER:EAT_gearMenu", -5, [["expression", ""]], "1", "1"]];

// Menu for spawning items to the admin like bags and tools
	EAT_gearMenu = [["",true]];
	EAT_gearMenu = EAT_gearMenu + [["-- Gear Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_gearMenu = EAT_gearMenu + [["ToolBelt gear", [],"", -5, [["expression", format[_EXECgear,"toolBeltItems.sqf"]]], "1", "1"]];
	EAT_gearMenu = EAT_gearMenu + [["Medical gear", [],"", -5, [["expression", format[_EXECgear,"medical.sqf"]]], "1", "1"]];
	EAT_gearMenu = EAT_gearMenu + [["Alice Pack", [],"", -5, [["expression", format[_EXECbackpacks,"DZ_ALICE_Pack_EP1"]]], "1", "1"]];
	EAT_gearMenu = EAT_gearMenu + [["Large Gun Bag", [],"", -5, [["expression", format[_EXECbackpacks,"DZ_LargeGunBag_EP1"]]], "1", "1"]];
	EAT_gearMenu = EAT_gearMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_gearMenu = EAT_gearMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// Main crate menu
	EAT_crateMenu = [["",true]];
	EAT_crateMenu = EAT_crateMenu + [["-- Crate Menu --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_crateMenu = EAT_crateMenu + [["Crate Menu >>",[],"#USER:EAT_crateMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_crateMenu = EAT_crateMenu + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_crateMenu = EAT_crateMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// This menu selects a crate type to send to the server to spawn
	// Entry Format: ["name",[],"",-5,[["expression",format[_EXECcrates,"cratetype"]]],"1","1"]];
	EAT_crateMenu = [["",true]];
	EAT_crateMenu = EAT_crateMenu + [["-- Crates --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_crateMenu = EAT_crateMenu + [["Epoch Weapons Crate",[],"",-5,[["expression",format[_EXECcrates,"EpochWeapons"]]],"1","1"]];
	if(EAT_isOverpoch)then{EAT_crateMenu = EAT_crateMenu + [["Overwatch Weapons Crate",[],"",-5,[["expression",format[_EXECcrates,"OverwatchWeapons"]]],"1","1"]];};
	EAT_crateMenu = EAT_crateMenu + [["Items Crate",[],"",-5,[["expression",format[_EXECcrates,"Items"]]],"1","1"]];
	EAT_crateMenu = EAT_crateMenu + [["ALL Weapons/Items Crate",[],"",-5,[["expression",format[_EXECcrates,"AllWeapons"]]],"1","1"]];
	EAT_crateMenu = EAT_crateMenu + [["Building Crate Menu >>",[],"#USER:EAT_BuildingCrateMenu", -5, [["expression", ""]], "1", "1"]];
	EAT_crateMenu = EAT_crateMenu + [["Backpack Tent",[],"",-5,[["expression",format[_EXECcrates,"Backpack"]]],"1","1"]];
	EAT_crateMenu = EAT_crateMenu + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_crateMenu = EAT_crateMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];
	
	EAT_BuildingCrateMenu =
	[
		["",true],
		["-- Building Crate Menu --", [], "", -5, [["expression", ""]], "1", "0"],
		["Admin Building Kit",[],"",-5,[["expression",format[_EXECcrates,"AllItemsBuilding"]]],"1","1"],
		["Small Cinder Kit",[],"",-5,[["expression",format[_EXECcrates,"smallCinderBuildingKit"]]],"1","1"],
		["Medium Cinder Kit",[],"",-5,[["expression",format[_EXECcrates,"mediumCinderBuildingKit"]]],"1","1"],
		["Large Cinder Kit",[],"",-5,[["expression",format[_EXECcrates,"largeCinderBuildingKit"]]],"1","1"],
		["Small Wood Kit",[],"",-5,[["expression",format[_EXECcrates,"smallWoodBuildingKit"]]],"1","1"],
		["Medium Wood Kit",[],"",-5,[["expression",format[_EXECcrates,"mediumWoodBuildingKit"]]],"1","1"],
		["Large Wood Kit",[],"",-5,[["expression",format[_EXECcrates,"largeWoodBuildingKit"]]],"1","1"],
		["", [], "", -5, [["expression", ""]], "1", "0"],
		["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]
	];

// Menu for changing time and weather
	EAT_weatherTimeMenu = [["",true]];
	EAT_weatherTimeMenu = EAT_weatherTimeMenu + [["-- Weather/Time Menu --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_weatherTimeMenu = EAT_weatherTimeMenu + [["Day Menu >>",[],"#USER:EAT_dayMenu",-5,[["expression",""]], "1", "1"]];
	EAT_weatherTimeMenu = EAT_weatherTimeMenu + [["Full-Moon Nights Menu >>",[],"#USER:EAT_fullMoonNight",-5,[["expression",""]], "1", "1"]];
	EAT_weatherTimeMenu = EAT_weatherTimeMenu + [["No-Moon Nights Menu >>",[],"#USER:EAT_noMoonNight",-5,[["expression",""]], "1", "1"]];
	EAT_weatherTimeMenu = EAT_weatherTimeMenu + [["Weather Menu >>",[],"#USER:EAT_weatherMenu",-5,[["expression",""]], "1", "1"]];
	EAT_weatherTimeMenu = EAT_weatherTimeMenu + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_weatherTimeMenu = EAT_weatherTimeMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

	// Dark nights
	EAT_noMoonNight = [["",true]];
	EAT_noMoonNight = EAT_noMoonNight + [["-- No moon night --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_noMoonNight = EAT_noMoonNight + [["8pm",[],"",-5,[["expression",format[_EXECdate,2012, 6, 19, 20]]],"1","1"]];
	EAT_noMoonNight = EAT_noMoonNight + [["10pm",[],"",-5,[["expression",format[_EXECdate,2012, 6, 19, 22]]],"1","1"]];
	EAT_noMoonNight = EAT_noMoonNight + [["Midnight",[],"",-5,[["expression",format[_EXECdate,2012, 6, 19, 0]]],"1","1"]];
	EAT_noMoonNight = EAT_noMoonNight + [["2am",[],"",-5,[["expression",format[_EXECdate,2012, 6, 19, 2]]],"1","1"]];
	EAT_noMoonNight = EAT_noMoonNight + [["4am",[],"",-5,[["expression",format[_EXECdate,2012, 6, 19, 4]]],"1","1"]];
	EAT_noMoonNight = EAT_noMoonNight + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_noMoonNight = EAT_noMoonNight + [["< Back", [], "#USER:EAT_weatherTimeMenu", -5, [["expression", ""]], "1", "1"]];

	// Normal nights
	EAT_fullMoonNight = [["",true]];
	EAT_fullMoonNight = EAT_fullMoonNight + [["-- Full moon night --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_fullMoonNight = EAT_fullMoonNight + [["8pm",[],"",-5,[["expression",format[_EXECdate,2012,6,4,20]]],"1","1"]];
	EAT_fullMoonNight = EAT_fullMoonNight + [["10pm",[],"",-5,[["expression",format[_EXECdate,2012,6,4,22]]],"1","1"]];
	EAT_fullMoonNight = EAT_fullMoonNight + [["Midnight",[],"",-5,[["expression",format[_EXECdate,2012,6,4,4]]],"1","1"]];
	EAT_fullMoonNight = EAT_fullMoonNight + [["2am",[],"",-5,[["expression",format[_EXECdate,2012,6,4,2]]],"1","1"]];
	EAT_fullMoonNight = EAT_fullMoonNight + [["4am",[],"",-5,[["expression",format[_EXECdate,2012,6,4,4]]],"1","1"]];
	EAT_fullMoonNight = EAT_fullMoonNight + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_fullMoonNight = EAT_fullMoonNight + [["< Back", [], "#USER:EAT_weatherTimeMenu", -5, [["expression", ""]], "1", "1"]];
	
	// Day time
	EAT_dayMenu = [["",true]];
	EAT_dayMenu = EAT_dayMenu + [["-- Set Day Time --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_dayMenu = EAT_dayMenu + [["5am",[],"",-5,[["expression",format[_EXECdate,2012,6,4,5]]],"1","1"]];
	EAT_dayMenu = EAT_dayMenu + [["7am",[],"",-5,[["expression",format[_EXECdate,2012,6,4,7]]],"1","1"]];
	EAT_dayMenu = EAT_dayMenu + [["9am",[],"",-5,[["expression",format[_EXECdate,2012,6,4,9]]],"1","1"]];
	EAT_dayMenu = EAT_dayMenu + [["11am",[],"",-5,[["expression",format[_EXECdate,2012,6,4,11]]],"1","1"]];
	EAT_dayMenu = EAT_dayMenu + [["Noon",[],"",-5,[["expression",format[_EXECdate,2012,6,4,12]]],"1","1"]];
	EAT_dayMenu = EAT_dayMenu + [["1pm",[],"",-5,[["expression",format[_EXECdate,2012,6,4,13]]],"1","1"]];
	EAT_dayMenu = EAT_dayMenu + [["3pm",[],"",-5,[["expression",format[_EXECdate,2012,6,4,15]]],"1","1"]];
	EAT_dayMenu = EAT_dayMenu + [["5pm",[],"",-5,[["expression",format[_EXECdate,2012,6,4,17]]],"1","1"]];
	EAT_dayMenu = EAT_dayMenu + [["7pm",[],"",-5,[["expression",format[_EXECdate,2012,6,4,19]]],"1","1"]];
	EAT_dayMenu = EAT_dayMenu + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_dayMenu = EAT_dayMenu + [["< Back", [], "#USER:EAT_weatherTimeMenu", -5, [["expression", ""]], "1", "1"]];

	// Weather change menu
	EAT_weatherMenu = [["",true]];
	EAT_weatherMenu = EAT_weatherMenu + [["-- Set Weather --",[],"",-5,[["expression",""]],"1","0"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Clear Sky",[],"",-5,[["expression",format[_EXECcloud,0]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Slightly Cloudy",[],"",-5,[["expression",format[_EXECcloud,0.25]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Cloudy",[],"",-5,[["expression",format[_EXECcloud,0.5]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Very Cloudy",[],"",-5,[["expression",format[_EXECcloud,0.75]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Storm",[],"",-5,[["expression",format[_EXECcloud,1]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_weatherMenu = EAT_weatherMenu + [["-- Set Fog --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Off",[],"",-5,[["expression",format[_EXECfog,0]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Thin",[],"",-5,[["expression",format[_EXECfog,0.25]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Medium",[],"",-5,[["expression",format[_EXECfog,0.5]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Thick",[],"",-5,[["expression",format[_EXECfog,0.75]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["Maximum",[],"",-5,[["expression",format[_EXECfog,1]]],"1","1"]];
	EAT_weatherMenu = EAT_weatherMenu + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_weatherMenu = EAT_weatherMenu + [["< Back", [], "#USER:EAT_weatherTimeMenu", -5, [["expression", ""]], "1", "1"]];

// Menu that deals with epoch specific items like locks and safes
	EAT_epochMenu = [["",true]];
	EAT_epochMenu = EAT_epochMenu + [["-- Epoch Only Menu --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_epochMenu = EAT_epochMenu + [["Admin Build Menu >> ",[],"#USER:EAT_buildMenu", -5,[["expression",""]],"1","1"]];
	EAT_epochMenu = EAT_epochMenu + [["Base Manager Menu >>", [], "", -5, [["expression",format[_EXECgenTools,"base_manager.sqf"]]], "1", "1"]];
	EAT_epochMenu = EAT_epochMenu + [["Cursor Target Menu >>",[],"#USER:EAT_pointMenu", -5,[["expression",""]],"1","1"]];
	EAT_epochMenu = EAT_epochMenu + [["Get current position",[],"",-5,[["expression",'[player] execVM "dayz_code\admintools\tools\getPosition.sqf"']],"1","1"]];
	EAT_epochMenu = EAT_epochMenu + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_epochMenu = EAT_epochMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// Menu that deals with cursor target items like locks and safes
	EAT_pointMenu = [["",true]];
	EAT_pointMenu = EAT_pointMenu + [["-- Cursor Target Menu --", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_pointMenu = EAT_pointMenu + [["Point to get position",[],"",-5,[["expression",'[cursorTarget] execVM "dayz_code\admintools\tools\getPosition.sqf"']],"1","1"]];
	EAT_pointMenu = EAT_pointMenu + [["Point to display code",[],"",-5,[["expression",format[_EXECgenTools,"displayLockCode.sqf"]]],"1","1"]];
	EAT_pointMenu = EAT_pointMenu + [["Point to make new key",[],"",-5,[["expression",format[_EXECgenTools,"recoverKey.sqf"]]],"1","1"]];
	EAT_pointMenu = EAT_pointMenu + [["Point to lock object",[],"",-5,[["expression",format[_EXECgenTools,"PointToLock.sqf"]]],"1","1"]];
	EAT_pointMenu = EAT_pointMenu + [["Point to unlock object",[],"",-5,[["expression",format[_EXECgenTools,"PointToUnlock.sqf"]]],"1","1"]];
	EAT_pointMenu = EAT_pointMenu + [["Point to Delete Item",[],"", -5,[["expression",format[_EXECgenTools,"DatabaseRemove.sqf"]]],"1","1"]];
	EAT_pointMenu = EAT_pointMenu + [["", [], "", -5, [["expression", ""]], "1", "0"]];
	EAT_pointMenu = EAT_pointMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// Base menu for Admin Build functions
	EAT_buildMenu = [["",true]];
	EAT_buildMenu = EAT_buildMenu + [["-- Admin Build Menu --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_buildMenu = EAT_buildMenu + [["Rebuild last item",[],"", -5,[["expression",format[_EXECadminBuild,"rebuild"]]],"1","1"]];
	EAT_buildMenu = EAT_buildMenu + [["Building GUI", [],"", -5, [["expression", format[_EXECbuildings,"buildingsDialog.sqf"]]], "1", "1"]];
	EAT_buildMenu = EAT_buildMenu + [["Base Materials >>",[],"#USER:EAT_baseItems", -5,[["expression",""]],"1","1"]];
	EAT_buildMenu = EAT_buildMenu + [["Storage >>",[],"#USER:EAT_buildStorage", -5,[["expression",""]],"1","1"]];
	EAT_buildMenu = EAT_buildMenu + [["Netting >>",[],"#USER:EAT_buildNetting", -5,[["expression",""]],"1","1"]];
	EAT_buildMenu = EAT_buildMenu + [["Sandbags >>",[],"#USER:EAT_buildSandbag", -5,[["expression",""]],"1","1"]];
	EAT_buildMenu = EAT_buildMenu + [["Extras >>",[],"#USER:EAT_buildExtras", -5,[["expression",""]],"1","1"]];
	EAT_buildMenu = EAT_buildMenu + [["Point To Upgrade",[],"", -5,[["expression",format[_EXECbuildings,"pointToUpgrade.sqf"]]],"1","1"]];
	EAT_buildMenu = EAT_buildMenu + [["Point To Downgrade",[],"", -5,[["expression",format[_EXECbuildings,"pointToDowngrade.sqf"]]],"1","1"]];
	EAT_buildMenu = EAT_buildMenu + [["Maintain Base",[],"", -5,[["expression",format[_EXECbuildings,"maintainArea.sqf"]]],"1","1"]];
	EAT_buildMenu = EAT_buildMenu + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_buildMenu = EAT_buildMenu + [["Main Menu", [20], "#USER:EAT_mainMenu", -5, [["expression", ""]], "1", "1"]];

// Standard base building epoch items
	EAT_baseItems = [["",true]];
	EAT_baseItems = EAT_baseItems + [["-- Base Items --", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_baseItems = EAT_baseItems + [["Cinder >>",[],"#USER:EAT_buildablesCinders", -5,[["expression",""]],"1","1"]];
	EAT_baseItems = EAT_baseItems + [["Wood >>",[],"#USER:EAT_buildablesWood", -5,[["expression",""]],"1","1"]];
	EAT_baseItems = EAT_baseItems + [["Other >>",[],"#USER:EAT_buildablesOther", -5,[["expression",""]],"1","1"]];
	EAT_baseItems = EAT_baseItems + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_baseItems = EAT_baseItems + [["< Back", [], "#USER:EAT_buildMenu", -5, [["expression", ""]], "1", "1"]];

// Wood epoch base items
	EAT_buildablesWood = [["",true]];
	EAT_buildablesWood = EAT_buildablesWood + [["-- Build Wood --",[],"",-5,[["expression",""]],"1","0"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Floor (Full)",[],"", -5,[["expression",format[_EXECadminBuild,"WoodFloor_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Floor (1/2)",[],"", -5,[["expression",format[_EXECadminBuild,"WoodFloorHalf_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Floor (1/4)",[],"", -5,[["expression",format[_EXECadminBuild,"WoodFloorQuarter_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Wall (Large)",[],"", -5,[["expression",format[_EXECadminBuild,"WoodLargeWall_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Wall (Small)",[],"", -5,[["expression",format[_EXECadminBuild,"WoodSmallWall_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Wall (1/3)",[],"", -5,[["expression",format[_EXECadminBuild,"WoodSmallWallThird_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Wall /w Window (Large)",[],"", -5,[["expression",format[_EXECadminBuild,"WoodLargeWallWin_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Wall /w Window (Small)",[],"", -5,[["expression",format[_EXECadminBuild,"WoodSmallWallWin_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Garage Doorway",[],"", -5,[["expression",format[_EXECadminBuild,"WoodLargeWallDoor_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Normal Doorway",[],"", -5,[["expression",format[_EXECadminBuild,"WoodSmallWallDoor_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Stairs",[],"", -5,[["expression",format[_EXECadminBuild,"WoodStairsSans_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Stairs /w Rails",[],"", -5,[["expression",format[_EXECadminBuild,"WoodStairsRails_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Stairs /w Stilts",[],"", -5,[["expression",format[_EXECadminBuild,"WoodStairs_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Ramp",[],"", -5,[["expression",format[_EXECadminBuild,"WoodRamp_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["Ladder",[],"", -5,[["expression",format[_EXECadminBuild,"WoodLadder_DZ"]]],"1","1"]];
	EAT_buildablesWood = EAT_buildablesWood + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_buildablesWood = EAT_buildablesWood + [["< Back", [], "#USER:EAT_buildMenu", -5, [["expression", ""]], "1", "1"]];

// Cinder epoch base items
	EAT_buildablesCinders = [["",true]];
	EAT_buildablesCinders = EAT_buildablesCinders + [["-- Build Cinder --",[],"",-5,[["expression",""]],"1","0"]];
	EAT_buildablesCinders = EAT_buildablesCinders + [["Wall (Full)",[],"", -5,[["expression",format[_EXECadminBuild,"CinderWall_DZ"]]],"1","1"]];
	EAT_buildablesCinders = EAT_buildablesCinders + [["Wall (Half)",[],"", -5,[["expression",format[_EXECadminBuild,"CinderWallHalf_DZ"]]],"1","1"]];
	EAT_buildablesCinders = EAT_buildablesCinders + [["Garage Doorway",[],"", -5,[["expression",format[_EXECadminBuild,"CinderWallDoorway_DZ"]]],"1","1"]];
	EAT_buildablesCinders = EAT_buildablesCinders + [["Normal Doorway",[],"", -5,[["expression",format[_EXECadminBuild,"CinderWallSmallDoorway_DZ"]]],"1","1"]];
	EAT_buildablesCinders = EAT_buildablesCinders + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_buildablesCinders = EAT_buildablesCinders + [["< Back", [], "#USER:EAT_buildMenu", -5, [["expression", ""]], "1", "1"]];

// Anything that does not fit into the BaseItems categories
	EAT_buildablesOther = [["",true]];
	EAT_buildablesOther = EAT_buildablesOther + [["-- Build Other --",[],"",-5,[["expression",""]],"1","0"]];
	EAT_buildablesOther = EAT_buildablesOther + [["Metal Floor",[],"", -5,[["expression",format[_EXECadminBuild,"MetalFloor_DZ"]]],"1","1"]];
	EAT_buildablesOther = EAT_buildablesOther + [["Metal Panel",[],"", -5,[["expression",format[_EXECadminBuild,"MetalPanel_DZ"]]],"1","1"]];
	EAT_buildablesOther = EAT_buildablesOther + [["Tank Trap",[],"", -5,[["expression",format[_EXECadminBuild,"Hedgehog_DZ"]]],"1","1"]];
	EAT_buildablesOther = EAT_buildablesOther + [["Wire Fence",[],"", -5,[["expression",format[_EXECadminBuild,"Fort_RazorWire"]]],"1","1"]];
	EAT_buildablesOther = EAT_buildablesOther + [["Plot Pole",[],"", -5,[["expression",format[_EXECadminBuild,"Plastic_Pole_EP1_DZ"]]],"1","1"]];
	EAT_buildablesOther = EAT_buildablesOther + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_buildablesOther = EAT_buildablesOther + [["< Back", [], "#USER:EAT_buildMenu", -5, [["expression", ""]], "1", "1"]];

// Storage items for base
	EAT_buildStorage = [["",true]];
	EAT_buildStorage = EAT_buildStorage + [["-- Build Storage --",[],"",-5,[["expression",""]],"1","0"]];
	EAT_buildStorage = EAT_buildStorage + [["Wooden Shed",[],"", -5,[["expression",format[_EXECadminBuild,"Wooden_shed_DZ"]]],"1","1"]];
	EAT_buildStorage = EAT_buildStorage + [["Wooden Shack",[],"", -5,[["expression",format[_EXECadminBuild,"WoodShack_DZ"]]],"1","1"]];
	EAT_buildStorage = EAT_buildStorage + [["Storage Shed",[],"", -5,[["expression",format[_EXECadminBuild,"StorageShed_DZ"]]],"1","1"]];
	EAT_buildStorage = EAT_buildStorage + [["Wood Crate",[],"", -5,[["expression",format[_EXECadminBuild,"WoodCrate_DZ"]]],"1","1"]];
	EAT_buildStorage = EAT_buildStorage + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_buildStorage = EAT_buildStorage + [["< Back", [], "#USER:EAT_buildMenu", -5, [["expression", ""]], "1", "1"]];

// Any buildable dealing with sand bags
	EAT_buildSandbag = [["",true]];
	EAT_buildSandbag = EAT_buildSandbag + [["-- Build Sandbags --",[],"",-5,[["expression",""]],"1","0"]];
	EAT_buildSandbag = EAT_buildSandbag + [["Sandbag Fence",[],"", -5,[["expression",format[_EXECadminBuild,"Sandbag1_DZ"]]],"1","1"]];
	EAT_buildSandbag = EAT_buildSandbag + [["Sandbag Fence (round)",[],"", -5,[["expression",format[_EXECadminBuild,"BagFenceRound_DZ"]]],"1","1"]];
	EAT_buildSandbag = EAT_buildSandbag + [["H-barrier Cube",[],"", -5,[["expression",format[_EXECadminBuild,"Land_HBarrier1_DZ"]]],"1","1"]];
	EAT_buildSandbag = EAT_buildSandbag + [["H-barrier (short)",[],"", -5,[["expression",format[_EXECadminBuild,"Land_HBarrier3_DZ"]]],"1","1"]];
	EAT_buildSandbag = EAT_buildSandbag + [["H-barrier (long)",[],"", -5,[["expression",format[_EXECadminBuild,"Land_HBarrier5_DZ"]]],"1","1"]];
	EAT_buildSandbag = EAT_buildSandbag + [["H-Barrier (Huge)",[],"", -5,[["expression",format[_EXECadminBuild,"Base_WarfareBBarrier10xTall","building"]]],"1","1"]];
	EAT_buildSandbag = EAT_buildSandbag + [["Sandbag Nest",[],"", -5,[["expression",format[_EXECadminBuild,"SandNest_DZ"]]],"1","1"]];
	EAT_buildSandbag = EAT_buildSandbag + [["M240 Nest",[],"", -5,[["expression",format[_EXECadminBuild,"M240Nest_DZ"]]],"1","1"]];
	EAT_buildSandbag = EAT_buildSandbag + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_buildSandbag = EAT_buildSandbag + [["< Back", [], "#USER:EAT_buildMenu", -5, [["expression", ""]], "1", "1"]];

// Cloth nets/huts
	EAT_buildNetting = [["",true]];
	EAT_buildNetting = EAT_buildNetting + [["-- Build Net/Hut --",[],"",-5,[["expression",""]],"1","0"]];
	EAT_buildNetting = EAT_buildNetting + [["Camo Net (Desert)",[],"", -5,[["expression",format[_EXECadminBuild,"DesertCamoNet_DZ"]]],"1","1"]];
	EAT_buildNetting = EAT_buildNetting + [["Camo Net (Forest)",[],"", -5,[["expression",format[_EXECadminBuild,"ForestCamoNet_DZ"]]],"1","1"]];
	EAT_buildNetting = EAT_buildNetting + [["Camo Net Large (Desert)",[],"", -5,[["expression",format[_EXECadminBuild,"DesertLargeCamoNet_DZ"]]],"1","1"]];
	EAT_buildNetting = EAT_buildNetting + [["Camo Net Large (Forest)",[],"", -5,[["expression",format[_EXECadminBuild,"ForestLargeCamoNet_DZ"]]],"1","1"]];
	EAT_buildNetting = EAT_buildNetting + [["Canvas Hut",[],"", -5,[["expression",format[_EXECadminBuild,"CanvasHut_DZ"]]],"1","1"]];
	EAT_buildNetting = EAT_buildNetting + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_buildNetting = EAT_buildNetting + [["< Back", [], "#USER:EAT_buildMenu", -5, [["expression", ""]], "1", "1"]];

// Anything that does not fall into the other categories
	EAT_buildExtras = [["",true]];
	EAT_buildExtras = EAT_buildExtras + [["-- Build MISC --",[],"",-5,[["expression",""]],"1","0"]];
	EAT_buildExtras = EAT_buildExtras + [["Fire Barrel",[],"", -5,[["expression",format[_EXECadminBuild,"FireBarrel_DZ"]]],"1","1"]];
	EAT_buildExtras = EAT_buildExtras + [["Workbench",[],"", -5,[["expression",format[_EXECadminBuild,"WorkBench_DZ"]]],"1","1"]];
	EAT_buildExtras = EAT_buildExtras + [["Generator",[],"", -5,[["expression",format[_EXECadminBuild,"Generator_DZ"]]],"1","1"]];
	EAT_buildExtras = EAT_buildExtras + [["Fuel Pump",[],"", -5,[["expression",format[_EXECadminBuild,"FuelPump_DZ"]]],"1","1"]];
	EAT_buildExtras = EAT_buildExtras + [["Deer Stand",[],"", -5,[["expression",format[_EXECadminBuild,"DeerStand_DZ"]]],"1","1"]];
	EAT_buildExtras = EAT_buildExtras + [["Park Bench",[],"", -5,[["expression",format[_EXECadminBuild,"ParkBench_DZ"]]],"1","1"]];
	EAT_buildExtras = EAT_buildExtras + [["", [], "", -5,[["expression", ""]], "1", "0"]];
	EAT_buildExtras = EAT_buildExtras + [["< Back", [], "#USER:EAT_buildMenu", -5, [["expression", ""]], "1", "1"]];
};

showCommandingMenu "#USER:EAT_mainMenu";
