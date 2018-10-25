# Changelog
All notable changes to this project will be documented in this file.

## [1.0.0] - 2018-10-25

### Changed
- Fixed server_monitor to properly spawn events.
- Fixed server_spawnCarePackages.sqf (wrong hpp paths)
- Fixed Fireworks script, to delete item on deploy from inventory
- Fixed player_updateGUI scripts not taking the playerUID properly.

### Added
- In variables.sqf added ***playableUnits set [count playableUnits, player];*** to emulate player log in (meaning 1 alive player)
