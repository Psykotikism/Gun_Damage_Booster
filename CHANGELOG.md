# Changelog

## Version 7.5 (June 1, 2022)

1. Changes:

- Lowered the limit of the damage boost settings from `999999` to `99999`.
- Added the `sm_boost` command. (Requested by `gamer_kanelita` and `Lagg`.)
- Added the `sm_damage` command. (Requested by `weffer`.)
- Added the `gdb_friendlyfire` convar.
- Added the `gdb_global` convar.
- Added the `gdb_launcher` convar. (Requested by `Sunyata`.)
- Damage boosts are now applied to Witches. (Requested by `Sunyata`.)
- Added notification flags to each convar.
- Made the `gdb_pluginversion` convar unchangeable outside of the source code.

## Version 7.0 (October 14, 2020)

1. Changes:

- Settings for L4D2-exclusive weapons are no longer created in L4D1.
- Raised the limit of the damage boost settings from `99999` to `999999`.
- Damage boosts are no longer applied against teammates.
- Damage boosts are now applied to all entities, not just players.
- Added the `gdb_gamemodetypes` convar. (Thanks to `Silvers` for the code!)

## Version 6.5 (August 23, 2018)

1. Changes:

- Removed the `OnClientDisconnect()` portion of the code.
- Removed the `bIsInfected()` check so the damage boost applies towards friendly-fire as well.

## Version 6.0 (August 6, 2018)

1. Changes:

- The code now uses `OnTakeDamage` instead of player_hurt.
- Added support for late loads.

## Version 5.5 (June 21, 2018)

1. Changes:

- Optimized code a bit.

## Version 5.0 (June 18, 2018)

1. Bug fixes:

- Fixed the `gdb_enabledgamemodes` and `gdb_disabledgamemodes` convars not working properly.

## Version 4.5 (June 16, 2018)

1. Bug fixes:

- Fixed the `gdb_enabledgamemodes` and `gdb_disabledgamemodes` convars not working properly.

## Version 4.0 (June 13, 2018)

1. Combined all different versions into 1 file.
2. Removed unnecessary code.

## Version 3.0 (November 21, 2017)

1. Converted to new syntax.

## Version 2.0 (November 12, 2017)

1. Cleaned up some code for each version.
2. Added a version that supports CSS weapons unlocked by mods or other plugins.

## Version 1.0 (September 29, 2017)

Initial Release.