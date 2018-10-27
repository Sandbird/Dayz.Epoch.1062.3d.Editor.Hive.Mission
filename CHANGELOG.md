# Changelog
All notable changes to this project will be documented in this file.

## [1.0.2] - 2018-10-27

### Changed
- Fixed player_switchModel.sqf, server_functions.sqf, player_monitor.sqf to properly retrieve and update player stats in the db.

## [1.0.1] - 2018-10-26

### Changed
- Fixed a couple adminTools files that spawn objects

## [1.0.0] - 2018-10-25

### Changed
- Fixed server_monitor to properly spawn events.
- Fixed server_spawnCarePackages.sqf (wrong hpp paths)
- Fixed Fireworks script, to delete item on deploy from inventory
- Fixed player_updateGUI scripts not taking the playerUID properly.

### Added
- In variables.sqf added ***playableUnits set [count playableUnits, player];*** to emulate player log in (meaning 1 alive player)
