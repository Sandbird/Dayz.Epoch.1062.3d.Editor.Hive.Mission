private [];

player removeMagazine "ItemNewspaper";

PVDZE_plr_DeathB = [player];
publicVariableServer  "PVDZE_plr_DeathB";
PVDZE_plr_DeathB spawn server_deaths;

waitUntil {!isNil "PVDZE_plr_DeathBResult"};

if((count PVDZE_plr_DeathBResult) > 0) then {
	// load death message board ui
	call EpochDeathBoardLoad;
} else {
	localize "str_epoch_player_36" call dayz_rollingMessages;
	PVDZE_plr_DeathBResult = nil;
};