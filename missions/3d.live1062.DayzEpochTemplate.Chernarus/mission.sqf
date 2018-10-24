activateAddons [ 
  "chernarus",
  "map_eu",
  "ca_modules_animals",
  "dayz_anim",
  "dayz_code",
  "dayz_communityassets",
  "dayz_weapons",
  "dayz_equip",
  "cacharacters_pmc",
  "ca_modules_functions",
  "zero_buildings",
  "dayz_epoch",
  "glt_m300t",
  "pook_h13",
  "csj_gyroac",
  "jetskiyanahuiaddon",
  "redryder",
  "Anzio_20"
];

activateAddons ["chernarus", "map_eu", "ca_modules_animals", "dayz_anim", "dayz_code", "dayz_communityassets", "dayz_weapons", "dayz_equip", "cacharacters_pmc", "ca_modules_functions", "zero_buildings", "dayz_epoch", "glt_m300t", "pook_h13", "csj_gyroac", "jetskiyanahuiaddon", "redryder", "Anzio_20"];
initAmbientLife;

_this = createCenter west;
_center_0 = _this;

_group_0 = createGroup _center_0;

_unit_1 = objNull;
if (true) then
{
  _this = _group_0 createUnit ["Camo1_DZ", [6388.1035, 7761.2344], [], 0, "CAN_COLLIDE"];
  _unit_1 = _this;
  _this setDir 47.685612;
  _this setVehicleVarName "Sandbird";
  Sandbird = _this;
  _this setUnitAbility 0.60000002;
  if (true) then {_group_0 selectLeader _this;};
  if (true) then {selectPlayer _this;};
  if (true) then {setPlayable _this;};
};

_vehicle_1 = objNull;
if (true) then
{
  _this = createVehicle ["SUV_Camo_DZE3", [6390.2095, 7748.9175, -0.028254064], [], 0, "CAN_COLLIDE"];
  _vehicle_1 = _this;
  _this setDir -122.54756;
  _this setVehicleLock "UNLOCKED";
  _this setPos [6390.2095, 7748.9175, -0.028254064];
};

_unit_2 = objNull;
if (true) then
{
  _this = _group_0 createUnit ["BAF_Soldier_AA_W", [6391.2095, 7745.9175, -0.028254064], [], 0, "CAN_COLLIDE"];
  _unit_2 = _this;
  _this setDir -138.015;
  _this setVehicleVarName "Bot1";
  Bot1 = _this;
  _this setVehicleInit "botInitScript = [this] execVM ""custom\BotInit.sqf"";";
  _this setUnitRank "CORPORAL";
  _this setUnitAbility 0.60000002;
  if (false) then {_group_0 selectLeader _this;};
};

_this = createCenter civilian;
_center_1 = _this;

_group_2 = createGroup _center_1;

_this = createCenter east;
_center_2 = _this;

_group_3 = createGroup _center_2;

_unit_7 = objNull;
if (true) then
{
  _this = _group_3 createUnit ["Ins_Villager4", [6390.2095, 7743.9175, -0.028254064], [], 0, "CAN_COLLIDE"];
  _unit_7 = _this;
  _this setDir -128.43231;
  _this setVehicleArmor 0.89999998;
  _this setVehicleAmmo 0.89999998;
  _this setVehicleInit "this setVariable [""CharacterID"", ""3"", true]; this setVariable [""playerUID"", ""333333"", true]; this setVariable [""friendlies"", [""111111""], true];";
  _this setUnitAbility 0.60000002;
  if (true) then {_group_3 selectLeader _this;};
};

processInitCommands;
runInitScript;
finishMissionInit;
