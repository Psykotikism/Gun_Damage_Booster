// Gun Damage Booster
#include <sourcemod>
#include <sdktools>
#pragma semicolon 1
#pragma newdecls required
#define GDB_VERSION "5.5"

public Plugin myinfo =
{
	name = "Gun Damage Booster",
	author = "Psyk0tik (Crasher_3637)",
	description = "Increases each gun's damage.",
	version = GDB_VERSION,
	url = "https://forums.alliedmods.net/showthread.php?t=301641"
};

ConVar g_cvGDBAK47;
ConVar g_cvGDBAWP;
ConVar g_cvGDBChrome;
ConVar g_cvGDBDisabledGameModes;
ConVar g_cvGDBEnable;
ConVar g_cvGDBEnabledGameModes;
ConVar g_cvGDBGameMode;
ConVar g_cvGDBHunting;
ConVar g_cvGDBM16;
ConVar g_cvGDBM60;
ConVar g_cvGDBMagnum;
ConVar g_cvGDBMilitary;
ConVar g_cvGDBMP5;
ConVar g_cvGDBPistol;
ConVar g_cvGDBPump;
ConVar g_cvGDBSCAR;
ConVar g_cvGDBScout;
ConVar g_cvGDBSG552;
ConVar g_cvGDBSilenced;
ConVar g_cvGDBSMG;
ConVar g_cvGDBSPAS;
ConVar g_cvGDBTactical;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion evEngine = GetEngineVersion();
	if (evEngine != Engine_Left4Dead && evEngine != Engine_Left4Dead2)
	{
		strcopy(error, err_max, "Gun Damage Booster only supports Left 4 Dead 1 & 2.");
		return APLRes_SilentFailure;
	}
	return APLRes_Success;
}

public void OnPluginStart()
{
	g_cvGDBAK47 = CreateConVar("gdb_ak47", "40", "Damage boost for the AK47 Assault Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBAWP = CreateConVar("gdb_awp", "50", "Damage boost for the AWP Sniper Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBChrome = CreateConVar("gdb_chrome", "20", "Damage boost for the Chrome Shotgun.", _, true, 0.0, true, 99999.0);
	g_cvGDBDisabledGameModes = CreateConVar("gdb_disabledgamemodes", "", "Disable the Gun Damage Booster in these game modes.\nGame mode limit: 64\nCharacter limit for each game mode: 32\n(Empty: None)\n(Not empty: Disabled in these game modes.)", _, true, 0.0, true, 99999.0);
	g_cvGDBEnable = CreateConVar("gdb_enable", "1", "Enable the Gun Damage Booster?\n(0: OFF)\n(1: ON)", _, true, 0.0, true, 99999.0);
	g_cvGDBEnabledGameModes = CreateConVar("gdb_enabledgamemodes", "", "Enable the Gun Damage Booster in these game modes.\nGame mode limit: 64\nCharacter limit for each game mode: 32\n(Empty: None)\n(Not empty: Enabled in these game modes.)", _, true, 0.0, true, 99999.0);
	g_cvGDBGameMode = FindConVar("mp_gamemode");
	g_cvGDBHunting = CreateConVar("gdb_hunting", "45", "Damage boost for the Hunting Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBM16 = CreateConVar("gdb_m16", "40", "Damage boost for the M16 Assault Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBM60 = CreateConVar("gdb_m60", "45", "Damage boost for the M60 Assault Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBMagnum = CreateConVar("gdb_magnum", "25", "Damage boost for the Magnum Pistol.", _, true, 0.0, true, 99999.0);
	g_cvGDBMilitary = CreateConVar("gdb_military", "50", "Damage boost for the Military Sniper Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBMP5 = CreateConVar("gdb_mp5", "30", "Damage boost for the MP5 SMG.", _, true, 0.0, true, 99999.0);
	g_cvGDBPistol = CreateConVar("gdb_pistol", "20", "Damage boost for the M1911/P220 Pistol.", _, true, 0.0, true, 99999.0);
	g_cvGDBPump = CreateConVar("gdb_pump", "20", "Damage boost for the Pump Shotgunn.", _, true, 0.0, true, 99999.0);
	g_cvGDBSCAR = CreateConVar("gdb_scar", "40", "Damage boost for the SCAR-L Desert Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBScout = CreateConVar("gdb_scout", "50", "Damage boost for the Scout Sniper Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBSG552 = CreateConVar("gdb_sg552", "40", "Damage boost for the SG552 Assault Rifle.", _, true, 0.0, true, 99999.0);
	g_cvGDBSilenced = CreateConVar("gdb_silenced", "35", "Damage boost for the Silenced SMG.", _, true, 0.0, true, 99999.0);
	g_cvGDBSMG = CreateConVar("gdb_smg", "30", "Damage boost for the SMG.", _, true, 0.0, true, 99999.0);
	g_cvGDBSPAS = CreateConVar("gdb_spas", "25", "Damage boost for the SPAS Shotgun.", _, true, 0.0, true, 99999.0);
	g_cvGDBTactical = CreateConVar("gdb_tactical", "25", "Damage boost for the Tactical Shotgun.", _, true, 0.0, true, 99999.0);
	HookEvent("player_hurt", eEventPlayerHurt);
	AutoExecConfig(true, "gun_damage_booster");
}

public Action eEventPlayerHurt(Event event, const char[] name, bool dontBroadcast)
{
	int iShooter = GetClientOfUserId(event.GetInt("attacker"));
	int iTarget = GetClientOfUserId(event.GetInt("userid"));
	if (g_cvGDBEnable.BoolValue && bIsSystemValid())
	{
		if (bIsSurvivor(iShooter) && bIsInfected(iTarget))
		{
			char sWeapon[32];
			event.GetString("weapon", sWeapon, sizeof(sWeapon));
			int iHealth = GetClientHealth(iTarget);
			if (StrEqual(sWeapon, "rifle_ak47", false))
			{
				int iDamage = g_cvGDBAK47.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "sniper_awp", false))
			{
				int iDamage = g_cvGDBAWP.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "shotgun_chrome", false))
			{
				int iDamage = g_cvGDBChrome.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "hunting_rifle", false))
			{
				int iDamage = g_cvGDBHunting.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "rifle", false))
			{
				int iDamage = g_cvGDBM16.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "rifle_m60", false))
			{
				int iDamage = g_cvGDBM60.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "pistol_magnum", false))
			{
				int iDamage = g_cvGDBMagnum.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "sniper_military", false))
			{
				int iDamage = g_cvGDBMilitary.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "smg_mp5", false))
			{
				int iDamage = g_cvGDBMP5.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "pistol", false))
			{
				int iDamage = g_cvGDBPistol.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "pumpshotgun", false))
			{
				int iDamage = g_cvGDBPump.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "rifle_desert", false))
			{
				int iDamage = g_cvGDBSCAR.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "sniper_scout", false))
			{
				int iDamage = g_cvGDBScout.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "rifle_sg552", false))
			{
				int iDamage = g_cvGDBSG552.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "smg_silenced", false))
			{
				int iDamage = g_cvGDBSilenced.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "smg", false))
			{
				int iDamage = g_cvGDBSMG.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "shotgun_spas", false))
			{
				int iDamage = g_cvGDBSPAS.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
			else if (StrEqual(sWeapon, "autoshotgun", false))
			{
				int iDamage = g_cvGDBTactical.IntValue;
				(iHealth - iDamage <= 0) ? SetEntityHealth(iTarget, 1) : SetEntityHealth(iTarget, iHealth - iDamage);
			}
		}
	}
}

stock bool bIsInfected(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 3 && IsPlayerAlive(client) && !IsClientInKickQueue(client);
}

stock bool bIsSurvivor(int client)
{
	return client > 0 && client <= MaxClients && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) && !IsClientInKickQueue(client);
}

stock bool bIsSystemValid()
{
	char sGameMode[32];
	char sConVarModes[32];
	g_cvGDBGameMode.GetString(sGameMode, sizeof(sGameMode));
	Format(sGameMode, sizeof(sGameMode), ",%s,", sGameMode);
	g_cvGDBEnabledGameModes.GetString(sConVarModes, sizeof(sConVarModes));
	if (strcmp(sConVarModes, ""))
	{
		Format(sConVarModes, sizeof(sConVarModes), ",%s,", sConVarModes);
		if (StrContains(sConVarModes, sGameMode, false) == -1)
		{
			return false;
		}
	}
	g_cvGDBDisabledGameModes.GetString(sConVarModes, sizeof(sConVarModes));
	if (strcmp(sConVarModes, ""))
	{
		Format(sConVarModes, sizeof(sConVarModes), ",%s,", sConVarModes);
		if (StrContains(sConVarModes, sGameMode, false) != -1)
		{
			return false;
		}
	}
	return true;
}