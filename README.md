# Gun Damage Booster

## PayPal
[Donate to Motivate](https://paypal.me/Psyk0tikism?locale.x=en_US)

## License
> The following license is placed inside the source code of the plugin.

Gun Damage Booster: a L4D/L4D2 SourceMod Plugin
Copyright (C) 2022  Alfred "Psyk0tik" Llagas

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

## About
Increases each gun's damage.

## Credits
**Crimson_Fox** - For the [[L4D2] Weapon Unlock](https://forums.alliedmods.net/showthread.php?t=114296) plugin.

**Silvers (Silvershot)** - For the code that allows users to enable/disable the plugin in certain game modes.

**Sunyata, gamer_kanelita, weffer, Lagg** - For suggesting ideas.

**SourceMod Team** - For continually updating/improving `SourceMod`.

## Requirements
1. `SourceMod 1.9` or higher
2. Recommended: [[L4D & L4D2] Left 4 DHooks Direct](https://forums.alliedmods.net/showthread.php?t=321696)

## Notes
1. I do not provide support for listen/local servers but the plugin should still work properly on them.
2. I will not help you with installing or troubleshooting problems on your part.
3. If you get errors from SourceMod itself, that is your problem, not mine.
4. MAKE SURE YOU MEET ALL THE REQUIREMENTS AND FOLLOW THE INSTALLATION GUIDE PROPERLY.

## Features
1. Boost each weapon's damage.
2. Boost weapon damage globally or per-player.
3. Supports CSS weapons.

## Commands
```
// Accessible by admins with "z" (Root) flag only.
sm_boost - Toggle a player's damage boost.

// Accessible by all players.
sm_damage - Show current gun damage boost settings.
```

## ConVar Settings
```
// Damage boost for the AK47 Assault Rifle.
// -
// Default: "40.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_ak47 "40.0"

// Damage boost for the AWP Sniper Rifle.
// -
// Default: "50.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_awp "50.0"

// Damage boost for the Chrome Shotgun.
// -
// Default: "20.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_chrome "20.0"

// Disable the Gun Damage Booster in these game modes.
// Game mode limit: 64
// Character limit for each game mode: 32
// Empty: None
// Not empty: Disabled in these game modes.
// -
// Default: ""
gdb_disabledgamemodes ""

// Enable the Gun Damage Booster?
// 0: OFF
// 1: ON
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
gdb_enable "1"

// Enable the Gun Damage Booster in these game modes.
// Game mode limit: 64
// Character limit for each game mode: 32
// Empty: None
// Not empty: Enabled in these game modes.
// -
// Default: ""
gdb_enabledgamemodes ""

// Enable the Gun Damage Booster for friendly-fire?
// 0: OFF
// 1: ON
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
gdb_friendlyfire "0"

// Enable the Gun Damage Booster in these game mode types.
// 0 OR 15: ALL
// 1: Co-op
// 2: Versus
// 3: Survival
// 4: Scavenge
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "15.000000"
gdb_gamemodetypes "0"

// Enable the Gun Damage Booster for everyone?
// 0: OFF
// 1: ON
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
gdb_global "1"

// Damage boost for the Hunting Rifle.
// -
// Default: "45.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_hunting "45.0"

// Damage boost for the Grenade Launcher.
// -
// Default: "75.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_launcher "75.0"

// Damage boost for the M16 Assault Rifle.
// -
// Default: "40.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_m16 "40.0"

// Damage boost for the M60 Assault Rifle.
// -
// Default: "45.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_m60 "45.0"

// Damage boost for the Magnum Pistol.
// -
// Default: "25.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_magnum "25.0"

// Damage boost for the Military Sniper Rifle.
// -
// Default: "50.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_military "50.0"

// Damage boost for the MP5 SMG.
// -
// Default: "30.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_mp5 "30.0"

// Damage boost for the M1911/P220 Pistol.
// -
// Default: "20.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_pistol "20.0"

// Damage boost for the Pump Shotgunn.
// -
// Default: "20.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_pump "20.0"

// Damage boost for the SCAR-L Desert Rifle.
// -
// Default: "40.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_scar "40.0"

// Damage boost for the Steyr Scout Sniper Rifle.
// -
// Default: "50.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_scout "50.0"

// Damage boost for the SG552 Assault Rifle.
// -
// Default: "40.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_sg552 "40.0"

// Damage boost for the Silenced SMG.
// -
// Default: "35.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_silenced "35.0"

// Damage boost for the SMG.
// -
// Default: "30.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_smg "30.0"

// Damage boost for the SPAS Shotgun.
// -
// Default: "25.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_spas "25.0"

// Damage boost for the Tactical Shotgun.
// -
// Default: "25.0"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_tactical "25.0"
```

## Installation
1. Delete files from old versions of the plugin.
3. Place `gun_damage_booster.smx` in the `addons/sourcemod/plugins` folder.
4. Place `gun_damage_booster.sp` in the `addons/sourcemod/scripting` folder.

## Uninstalling/Upgrading to Newer Versions
1. Delete `gun_damage_booster.sp` from the `addons/sourcemod/scripting` folder.
2. Delete `gun_damage_booster.smx` from the `addons/sourcemod/plugins` folder.
4. Follow the Installation guide above. (Only for upgrading to newer versions.)

## Disabling
1. Move `gun_damage_booster.smx` to the `plugins/disabled` folder.
2. Unload `Gun Damage Booster` by typing `sm plugins unload gun_damage_booster` in the server console.

## Questions You May Have
> If you have any questions that aren't addressed below, feel free to message me or post on this [thread](https://forums.alliedmods.net/showthread.php?t=301641).

1. How do I enable/disable the plugin in certain game modes?

You must specify the game modes in the `gdb_enabledgamemodes` and `gdb_disabledgamemodes` convars.

Here are some scenarios and their outcomes:

- Scenario 1
```
gdb_gamemodetypes "0" // The plugin is enabled in all game mode types.
gdb_enabledgamemodes "" // The plugin is enabled in all game modes.
gdb_disabledgamemodes "coop" // The plugin is disabled in Campaign mode.

Outcome: The plugin works in every game mode except in Campaign mode.
```
- Scenario 2
```
gdb_gamemodetypes "1" // The plugin is enabled in every Campaign-based game mode.
gdb_enabledgamemodes "coop" // The plugin is enabled in only Campaign mode.
gdb_disabledgamemodes "" // The plugin is not disabled at all.

Outcome: The plugin works only in Campaign mode.
```
- Scenario 3
```
gdb_gamemodetypes "5" // The plugin is enabled in every Campaign-based and Survival-based game mode.
gdb_enabledgamemodes "coop,versus" // The plugin is enabled in only Campaign and Versus modes.
gdb_disabledgamemodes "coop" // The plugin is disabled in Campaign mode.

Outcome: The plugin works only in Versus mode.
```

## Third-Party Revisions Notice
If you would like to share your own revisions of this plugin, please rename the files so that there is no confusion for users.

## Final Words
Enjoy all my hard work and have fun with it!