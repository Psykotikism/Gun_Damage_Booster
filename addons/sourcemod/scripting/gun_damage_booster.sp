/**
 * Gun Damage Booster: a L4D/L4D2 SourceMod Plugin
 * Copyright (C) 2022  Alfred "Psyk0tik" Llagas
 *
 * This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
 **/

#include <sourcemod>
#include <sdkhooks>
#include <sdktools>

#undef REQUIRE_PLUGIN
#tryinclude <left4dhooks>
#define REQUIRE_PLUGIN

#pragma semicolon 1
#pragma newdecls required

#define GDB_VERSION "7.5"

public Plugin myinfo =
{
	name = "[L4D & L4D2] Gun Damage Booster",
	author = "Psyk0tik",
	description = "Increases each gun's damage.",
	version = GDB_VERSION,
	url = "https://forums.alliedmods.net/showthread.php?t=301641"
};

bool g_bLateLoad, g_bLeft4Dead2;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion evEngine = GetEngineVersion();
	if (evEngine == Engine_Left4Dead)
	{
		g_bLeft4Dead2 = false;
	}
	else if (evEngine == Engine_Left4Dead2)
	{
		g_bLeft4Dead2 = true;
	}
	else if (evEngine != Engine_Left4Dead && evEngine != Engine_Left4Dead2)
	{
		strcopy(error, err_max, "\"Gun Damage Booster\" only supports Left 4 Dead 1 & 2.");

		return APLRes_SilentFailure;
	}

	g_bLateLoad = late;

	return APLRes_Success;
}

bool g_bMapStarted, g_bPluginEnabled;

ConVar g_cvGDBConVars[25];

int g_iCurrentMode;

#if defined _l4dh_included
bool g_bLeft4DHooks;

public void OnLibraryAdded(const char[] name)
{
	if (StrEqual(name, "left4dhooks", false))
	{
		g_bLeft4DHooks = true;
	}
}

public void OnLibraryRemoved(const char[] name)
{
	if (StrEqual(name, "left4dhooks", false))
	{
		g_bLeft4DHooks = false;
	}
}
#endif

public void OnPluginStart()
{
	RegConsoleCmd("sm_gdb_damage", cmdGDBDamage, "Show current gun damage boost settings.");

	g_cvGDBConVars[3] = CreateConVar("gdb_disabledgamemodes", "", "Disable the Gun Damage Booster in these game modes.\nGame mode limit: 64\nCharacter limit for each game mode: 32\nEmpty: None\nNot empty: Disabled in these game modes.");
	g_cvGDBConVars[4] = CreateConVar("gdb_enable", "1", "Enable the Gun Damage Booster?\n0: OFF\n1: ON", _, true, 0.0, true, 1.0);
	g_cvGDBConVars[5] = CreateConVar("gdb_enabledgamemodes", "", "Enable the Gun Damage Booster in these game modes.\nGame mode limit: 64\nCharacter limit for each game mode: 32\nEmpty: None\nNot empty: Enabled in these game modes.");
	g_cvGDBConVars[6] = CreateConVar("gdb_friendlyfire", "0", "Enable the Gun Damage Booster for friendly-fire?\n0: OFF\n1: ON", _, true, 0.0, true, 1.0);
	g_cvGDBConVars[7] = CreateConVar("gdb_gamemodetypes", "0", "Enable the Gun Damage Booster in these game mode types.\n0 OR 15: ALL\n1: Co-op\n2: Versus\n3: Survival\n4: Scavenge", _, true, 0.0, true, 15.0);
	g_cvGDBConVars[8] = FindConVar("mp_gamemode");
	g_cvGDBConVars[9] = CreateConVar("gdb_hunting", "45.0", "Damage boost for the Hunting Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBConVars[10] = CreateConVar("gdb_m16", "40.0", "Damage boost for the M16 Assault Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBConVars[15] = CreateConVar("gdb_pistol", "20.0", "Damage boost for the M1911/P220 Pistol.", _, true, 0.0, true, 99999.0);
	g_cvGDBConVars[16] = CreateConVar("gdb_pump", "20.0", "Damage boost for the Pump Shotgunn.", _, true, 0.0, true, 99999.0);
	g_cvGDBConVars[21] = CreateConVar("gdb_smg", "30.0", "Damage boost for the SMG.", _, true, 0.0, true, 99999.0);
	g_cvGDBConVars[23] = CreateConVar("gdb_tactical", "25.0", "Damage boost for the Tactical Shotgun.", _, true, 0.0, true, 99999.0);

	if (g_bLeft4Dead2)
	{
		g_cvGDBConVars[0] = CreateConVar("gdb_ak47", "40.0", "Damage boost for the AK47 Assault Rifle.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[1] = CreateConVar("gdb_awp", "50.0", "Damage boost for the AWP Sniper Rifle.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[2] = CreateConVar("gdb_chrome", "20.0", "Damage boost for the Chrome Shotgun.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[11] = CreateConVar("gdb_m60", "45.0", "Damage boost for the M60 Assault Rifle.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[12] = CreateConVar("gdb_magnum", "25.0", "Damage boost for the Magnum Pistol.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[13] = CreateConVar("gdb_military", "50.0", "Damage boost for the Military Sniper Rifle.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[14] = CreateConVar("gdb_mp5", "30.0", "Damage boost for the MP5 SMG.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[17] = CreateConVar("gdb_scar", "40.0", "Damage boost for the SCAR-L Desert Rifle.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[18] = CreateConVar("gdb_scout", "50.0", "Damage boost for the Scout Sniper Rifle.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[19] = CreateConVar("gdb_sg552", "40.0", "Damage boost for the SG552 Assault Rifle.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[20] = CreateConVar("gdb_silenced", "35.0", "Damage boost for the Silenced SMG.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[22] = CreateConVar("gdb_spas", "25.0", "Damage boost for the SPAS Shotgun.", _, true, 0.0, true, 99999.0);
		g_cvGDBConVars[24] = CreateConVar("gdb_launcher", "75.0", "Damage boost for the Grenade Launcher.", _, true, 0.0, true, 99999.0);
	}

	CreateConVar("gdb_version", GDB_VERSION, "Gun Damage Booster Version", FCVAR_DONTRECORD|FCVAR_NOTIFY|FCVAR_REPLICATED|FCVAR_SPONLY);
	AutoExecConfig(true, "gun_damage_booster");

	g_cvGDBConVars[3].AddChangeHook(vPluginStatusCvar);
	g_cvGDBConVars[4].AddChangeHook(vPluginStatusCvar);
	g_cvGDBConVars[5].AddChangeHook(vPluginStatusCvar);
	g_cvGDBConVars[7].AddChangeHook(vPluginStatusCvar);
	g_cvGDBConVars[8].AddChangeHook(vPluginStatusCvar);

	if (g_bLateLoad)
	{
		for (int iPlayer = 1; iPlayer <= MaxClients; iPlayer++)
		{
			if (IsClientInGame(iPlayer))
			{
				OnClientPutInServer(iPlayer);
			}
		}

		g_bLateLoad = false;
	}
}

public void OnMapStart()
{
	g_bMapStarted = true;
}

public void OnClientPutInServer(int client)
{
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}

public void OnMapEnded()
{
	g_bMapStarted = false;
}

public void OnConfigsExecuted()
{
	vPluginStatus();
}

public void OnEntityCreated(int entity, const char[] classname)
{
	if (g_cvGDBConVars[4].BoolValue && g_bPluginEnabled && bIsValidEntity(entity))
	{
		if (StrEqual(classname, "infected") || StrEqual(classname, "witch"))
		{
			SDKHook(entity, SDKHook_SpawnPost, OnInfectedSpawnPost);
		}
	}
}

Action cmdGDBDamage(int client, int args)
{
	ReplyToCommand(client, "\x04[SM]\x03 Gun damage boost settings:");
	ReplyToCommand(client, "\x01Hunting Rifle:\x05 %.2f", g_cvGDBConVars[9].FloatValue);
	ReplyToCommand(client, "\x01M16 Assault Rifle:\x05 %.2f", g_cvGDBConVars[10].FloatValue);
	ReplyToCommand(client, "\x01M1911 Pistol:\x05 %.2f", g_cvGDBConVars[15].FloatValue);
	ReplyToCommand(client, "\x01Pump Shotgun:\x05 %.2f", g_cvGDBConVars[16].FloatValue);
	ReplyToCommand(client, "\x01SMG:\x05 %.2f", g_cvGDBConVars[21].FloatValue);
	ReplyToCommand(client, "\x01Tactical Shotgun:\x05 %.2f", g_cvGDBConVars[23].FloatValue);

	if (g_bLeft4Dead2)
	{
		ReplyToCommand(client, "\x01AK47 Assault Rifle:\x05 %.2f", g_cvGDBConVars[0].FloatValue);
		ReplyToCommand(client, "\x01AWP Sniper Rifle:\x05 %.2f", g_cvGDBConVars[1].FloatValue);
		ReplyToCommand(client, "\x01Chrome Shotgun:\x05 %.2f", g_cvGDBConVars[2].FloatValue);
		ReplyToCommand(client, "\x01M60 Assault Rifle:\x05 %.2f", g_cvGDBConVars[11].FloatValue);
		ReplyToCommand(client, "\x01Magnum Pistol:\x05 %.2f", g_cvGDBConVars[12].FloatValue);
		ReplyToCommand(client, "\x01Military Sniper Rifle:\x05 %.2f", g_cvGDBConVars[13].FloatValue);
		ReplyToCommand(client, "\x01MP5 SMG:\x05 %.2f", g_cvGDBConVars[14].FloatValue);
		ReplyToCommand(client, "\x01SCAR-L Desert Rifle:\x05 %.2f", g_cvGDBConVars[17].FloatValue);
		ReplyToCommand(client, "\x01Scout Sniper Rifle:\x05 %.2f", g_cvGDBConVars[18].FloatValue);
		ReplyToCommand(client, "\x01SG552 Assault Rifle:\x05 %.2f", g_cvGDBConVars[19].FloatValue);
		ReplyToCommand(client, "\x01Silenced SMG:\x05 %.2f", g_cvGDBConVars[20].FloatValue);
		ReplyToCommand(client, "\x01SPAS Shotgun:\x05 %.2f", g_cvGDBConVars[22].FloatValue);
		ReplyToCommand(client, "\x01Grenade Launcher:\x05 %.2f", g_cvGDBConVars[24].FloatValue);
	}

	return Plugin_Handled;
}

void OnInfectedSpawnPost(int entity)
{
	SDKHook(entity, SDKHook_OnTakeDamage, OnTakeDamage);
}

Action OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
	if (g_cvGDBConVars[4].BoolValue && g_bPluginEnabled && bIsSurvivor(attacker) && damage > 0.0)
	{
		if (!g_cvGDBConVars[6].BoolValue && bIsValidClient(victim) && GetClientTeam(attacker) == GetClientTeam(victim))
		{
			return Plugin_Continue;
		}

		char sWeapon[128];
		GetClientWeapon(attacker, sWeapon, sizeof sWeapon);
		if (StrEqual(sWeapon, "weapon_rifle_ak47", false))
		{
			damage += g_cvGDBConVars[0].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_sniper_awp", false))
		{
			damage += g_cvGDBConVars[1].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_shotgun_chrome", false))
		{
			damage += g_cvGDBConVars[2].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_hunting_rifle", false))
		{
			damage += g_cvGDBConVars[9].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_rifle", false))
		{
			damage += g_cvGDBConVars[10].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_rifle_m60", false))
		{
			damage += g_cvGDBConVars[11].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_pistol_magnum", false))
		{
			damage += g_cvGDBConVars[12].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_sniper_military", false))
		{
			damage += g_cvGDBConVars[13].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_smg_mp5", false))
		{
			damage += g_cvGDBConVars[14].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_pistol", false))
		{
			damage += g_cvGDBConVars[15].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_pumpshotgun", false))
		{
			damage += g_cvGDBConVars[16].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_rifle_desert", false))
		{
			damage += g_cvGDBConVars[17].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_sniper_scout", false))
		{
			damage += g_cvGDBConVars[18].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_rifle_sg552", false))
		{
			damage += g_cvGDBConVars[19].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_smg_silenced", false))
		{
			damage += g_cvGDBConVars[20].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_smg", false))
		{
			damage += g_cvGDBConVars[21].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_shotgun_spas", false))
		{
			damage += g_cvGDBConVars[22].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_autoshotgun", false))
		{
			damage += g_cvGDBConVars[23].FloatValue;
		}
		else if (StrEqual(sWeapon, "weapon_grenade_launcher", false))
		{
			damage += g_cvGDBConVars[24].FloatValue;
		}

		return Plugin_Changed;
	}

	return Plugin_Continue;
}

void vPluginStatus()
{
	bool bPluginAllowed = bIsPluginEnabled();
	if (!g_bPluginEnabled && bPluginAllowed)
	{
		g_bPluginEnabled = true;
	}
	else if (g_bPluginEnabled && !bPluginAllowed)
	{
		g_bPluginEnabled = false;
	}
}

void vPluginStatusCvar(ConVar convar, const char[] oldValue, const char[] newValue)
{
	vPluginStatus();
}

bool bIsPluginEnabled()
{
	if (g_cvGDBConVars[8] == null)
	{
		return false;
	}

	int iMode = g_cvGDBConVars[7].IntValue;
	if (iMode != 0)
	{
		if (!g_bMapStarted)
		{
			return false;
		}

		g_iCurrentMode = 0;
#if defined _l4dh_included
		if (g_bLeft4DHooks)
		{
			g_iCurrentMode = L4D_GetGameModeType();
			if (g_iCurrentMode == 0 || !(iMode & g_iCurrentMode))
			{
				return false;
			}
		}
#else
		int iGameMode = CreateEntityByName("info_gamemode");
		if (IsValidEntity(iGameMode))
		{
			DispatchSpawn(iGameMode);

			HookSingleEntityOutput(iGameMode, "OnCoop", vGameMode, true);
			HookSingleEntityOutput(iGameMode, "OnSurvival", vGameMode, true);
			HookSingleEntityOutput(iGameMode, "OnVersus", vGameMode, true);
			HookSingleEntityOutput(iGameMode, "OnScavenge", vGameMode, true);

			ActivateEntity(iGameMode);
			AcceptEntityInput(iGameMode, "PostSpawnActivate");

			if (IsValidEntity(iGameMode))
			{
				RemoveEdict(iGameMode);
			}
		}

		if (g_iCurrentMode == 0 || !(iMode & g_iCurrentMode))
		{
			return false;
		}
#endif
	}

	char sFixed[32], sGameMode[32], sGameModes[513], sList[513];
	g_cvGDBConVars[8].GetString(sGameMode, sizeof sGameMode);
	FormatEx(sFixed, sizeof sFixed, ",%s,", sGameMode);

	g_cvGDBConVars[5].GetString(sGameModes, sizeof sGameModes);
	if (sGameModes[0] != '\0')
	{
		FormatEx(sList, sizeof sList, ",%s,", sGameModes);
		if (StrContains(sList, sFixed, false) == -1)
		{
			return false;
		}
	}

	g_cvGDBConVars[3].GetString(sGameModes, sizeof sGameModes);
	if (sGameModes[0] != '\0')
	{
		FormatEx(sList, sizeof sList, ",%s,", sGameModes);
		if (StrContains(sList, sFixed, false) != -1)
		{
			return false;
		}
	}

	return true;
}

bool bIsSurvivor(int client)
{
	return bIsValidClient(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client);
}

bool bIsValidClient(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && !IsClientInKickQueue(client);
}

bool bIsValidEntity(int entity)
{
	return entity > MaxClients && IsValidEntity(entity);
}

#if defined _l4dh_included
public void L4D_OnGameModeChange(int gamemode)
{
	int iMode = g_cvGDBConVars[7].IntValue;
	if (iMode != 0)
	{
		g_bPluginEnabled = (gamemode != 0 && (iMode & gamemode));
		g_iCurrentMode = gamemode;
	}
}
#else
void vGameMode(const char[] output, int caller, int activator, float delay)
{
	if (StrEqual(output, "OnCoop"))
	{
		g_iCurrentMode = 1;
	}
	else if (StrEqual(output, "OnVersus"))
	{
		g_iCurrentMode = 2;
	}
	else if (StrEqual(output, "OnSurvival"))
	{
		g_iCurrentMode = 4;
	}
	else if (StrEqual(output, "OnScavenge"))
	{
		g_iCurrentMode = 8;
	}
}
#endif