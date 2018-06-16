# Gun Damage Booster
I liked the idea of boosting the damage of each gun, so I decided to make this.

## License
Gun Damage Booster: a L4D/L4D2 SourceMod Plugin
Copyright (C) 2017  Alfred "Crasher_3637/Psyk0tik" Llagas

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

## About
Increases each gun's damage.

### What makes Gun Damage Booster viable in Left 4 Dead/Left 4 Dead 2?
The plugin boosts the damage. Nothing more, nothing less.

### Requirements
Gun Damage Booster was developed against SourceMod 1.8+.

### Installation
1. Delete files from old versions of the plugin.
2. Extract the folder inside the .zip file.
3. Place all the contents into their respective folders.
4. If prompted to replace or merge anything, click yes.
5. Load up Gun Damage Booster.
  - Type ```sm_rcon sm plugins load gun_damage_booster``` in console.
  - OR restart the server.
6. Customize Gun Damage Booster (Config file generated on first load).

### Uninstalling/Upgrading to Newer Versions
1. Delete gun_damage_booster.smx from addons/sourcemod/plugins folder.
2. Delete gun_damage_booster.sp from addons/sourcemod/scripting folder.
3. Delete gun_damage_booster.cfg from cfg/sourcemod folder.
4. Follow the Installation guide above. (Only for upgrading to newer versions.)

### Disabling
1. Move gun_damage_booster.smx to plugins/disabled folder.
2. Unload Gun Damage Booster.
  - Type ```sm_rcon sm plugins unload gun_damage_booster``` in console.
  - OR restart the server.

## Configuration Variables (ConVars/CVars)
```
// Damage boost for the AK47 Assault Rifle.
// -
// Default: "40"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_ak47 "40"

// Damage boost for the AWP Sniper Rifle.
// -
// Default: "50"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_awp "50"

// Damage boost for the Chrome Shotgun.
// -
// Default: "20"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_chrome "20"

// Disable the Gun Damage Booster in these game modes.
// Game mode limit: 64
// Character limit for each game mode: 32
// (Empty: None)
// (Not empty: Disabled in these game modes.)
// -
// Default: ""
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_disabledgamemodes ""

// Enable the Gun Damage Booster?
// (0: OFF)
// (1: ON)
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_enable "1"

// Enable the Gun Damage Booster in these game modes.
// Game mode limit: 64
// Character limit for each game mode: 32
// (Empty: None)
// (Not empty: Enabled in these game modes.)
// -
// Default: ""
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_enabledgamemodes ""

// Damage boost for the Hunting Rifle.
// -
// Default: "45"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_hunting "45"

// Damage boost for the M16 Assault Rifle.
// -
// Default: "40"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_m16 "40"

// Damage boost for the M60 Assault Rifle.
// -
// Default: "45"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_m60 "45"

// Damage boost for the Magnum Pistol.
// -
// Default: "25"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_magnum "25"

// Damage boost for the Military Sniper Rifle.
// -
// Default: "50"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_military "50"

// Damage boost for the MP5 SMG.
// -
// Default: "30"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_mp5 "30"

// Damage boost for the M1911/P220 Pistol.
// -
// Default: "20"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_pistol "20"

// Damage boost for the Pump Shotgunn.
// -
// Default: "20"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_pump "20"

// Damage boost for the SCAR-L Desert Rifle.
// -
// Default: "40"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_scar "40"

// Damage boost for the Scout Sniper Rifle.
// -
// Default: "50"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_scout "50"

// Damage boost for the SG552 Assault Rifle.
// -
// Default: "40"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_sg552 "40"

// Damage boost for the Silenced SMG.
// -
// Default: "35"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_silenced "35"

// Damage boost for the SMG.
// -
// Default: "30"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_smg "30"

// Damage boost for the SPAS Shotgun.
// -
// Default: "25"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_spas "25"

// Damage boost for the Tactical Shotgun.
// -
// Default: "25"
// Minimum: "0.000000"
// Maximum: "99999.000000"
gdb_tactical "25"
```

## Questions You May Have
> If you have any questions that aren't addressed below, feel free to message me or post on this [thread](https://forums.alliedmods.net/showthread.php?t=301641).

1. How do I enable/disable the plugin in certain game modes?

You must specify the game modes in the gdb_enabledgamemodes and gdb_disabledgamemodes convars.

Here are some scenarios and their outcomes:

- Scenario 1
```
gdb_enabledgamemodes "" // The plugin is enabled in all game modes.
gdb_disabledgamemodes "coop" // The plugin is disabled in Campaign mode.

Outcome: The plugin works in every game mode except in Campaign mode.
```
- Scenario 2
```
gdb_enabledgamemodes "coop" // The plugin is enabled in only Campaign mode.
gdb_disabledgamemodes "" // The plugin is not disabled at all.

Outcome: The plugin works only in Campaign mode.
```
- Scenario 3
```
gdb_enabledgamemodes "coop,versus" // The plugin is enabled in only Campaign and Versus modes.
gdb_disabledgamemodes "coop" // The plugin is disabled in Campaign mode.

Outcome: The plugin works only in Versus mode.
```

## Credits
Crimson_Fox - For the [Weapon Unlock](https://forums.alliedmods.net/showthread.php?t=114296) plugin.

# Contact Me
If you wish to contact me for any questions, concerns, suggestions, or criticism, I can be found here:
- [AlliedModders Forum](https://forums.alliedmods.net/member.php?u=181166)
- [Steam](https://steamcommunity.com/profiles/76561198056665335)

# 3rd-Party Revisions Notice
If you would like to share your own revisions of this plugin, please rename the files! I do not want to create confusion for end-users and it will avoid conflict and negative feedback on the official versions of my work. If you choose to keep the same file names for your revisions, it will cause users to assume that the official versions are the source of any problems your revisions may have. This is to protect you (the reviser) and me (the developer)! Thank you!

# Donate
- [Donate to SourceMod](https://www.sourcemod.net/donate.php)

Thank you very much! :)
