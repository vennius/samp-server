/*

    This script is designed to help new PAWN scripters get started quickly.
    It's like a friendly guidebook that covers the basics of starting a very simple script using MYSQL and Bcrypt for password hashing.
    This can be used as a base for your new gamemode.
    
    I'll try my best to keep this script newbie-friendly and will comment things extensively to help everyone understand.
    But you should at least have a basic understanding of how Pawn works.

    CREDITS
    Mido - Creation
    blueG - MYSQL Plugin
    Sys - Bcrypt Plugin

*/

// REMINDER: Fix Hunger System

// We are going to define MAX_PLAYERS before including open.mp so we don't have to undef it.
// Change the value to the "Slots" you want.
#define MAX_PLAYERS     28

#include <open.mp>
#include <a_mysql>  
#include <samp_bcrypt>
#include <Pawn.CMD>
#include <sscanf2>
#include <progress2>
#include <YSI_Core/y_compilerdata>
#include <YSI_Game/y_vehicledata>
#include <YSI_Core/y_utils>
#include <YSI_Coding/y_timers>

#pragma warning disable 213, 234, 204, 217

// main() is needed as the entry point, without it the mode won't start.
main() {}


// Forwards
forward OnPlayerAccountCheck(playerid);
forward OnPlayerHashPassword(playerid);
forward OnPlayerVerifyPassword(playerid, bool:success);
forward OnPlayerFinishRegistration(playerid);
forward TIMER_DelayedKick(playerid);

// This is going to be our MYSQL connection handle.
new MySQL:dbHandle;

// PLAYER DATA
enum E_PLAYER_DATA
{
    pAccountID,
    pName[MAX_PLAYER_NAME + 1],
    PasswordHash[BCRYPT_HASH_LENGTH],
    pBadLogins,
    bool:pLoggedIn,
    bool:pSpawned,
    pSkin,
    pScore,
    Float:player_pos_x,
    Float:player_pos_y,
    Float:player_pos_z,
    Float:player_pos_angle,
    pAdmin,
    pMoney,
    pHunger,
    pThirst
};
new pData[MAX_PLAYERS][E_PLAYER_DATA];


#include "MODULE/COLOR"
#include "MODULE/ENUM"
#include "MODULE/DEFINE"
#include "MODULE/TEXTDRAW"
#include "MODULE/DIALOG"

#include "MODULE/NATIVE"
#include "MODULE/FUNCTION"
#include "MODULE/TASK"

#include "COMMANDS/PLAYER"
#include "COMMANDS/ADMIN"

public OnGameModeInit()
{
    // We are going to be using mysql_connect_file to connect to our MySQL server and database,
    // using a INI-like file where all connection credentials and options are specified.
    // NOTE: You CANNOT specify any directories in the file name, the connection file HAS to and MUST be in the open.mp server root folder.

	new MySQLOpt: option_id = mysql_init_options();

	mysql_set_option(option_id, AUTO_RECONNECT, true);

    dbHandle = mysql_connect("127.0.0.1", "root", "", "samp", option_id);

    if(dbHandle == MYSQL_INVALID_HANDLE || mysql_errno(dbHandle) != 0)
    {
        // Our MySQL connection failed.
        print("MYSQL CONNECTION FAILED! Server is shutting down.");

        // Close the server.
        SendRconCommand("exit");

        return 1;
    }

    // MySQL connection succeeded
    print("MYSQL CONNECTION succeeded");

    return 1;
}

public OnGameModeExit()
{
    // Let's not forgot to close our database connection.
    mysql_close(dbHandle);

    return 1;
}

public OnPlayerConnect(playerid)
{
    pData[playerid][pSpawned] = false;
    // Player name
    GetPlayerName(playerid, pData[playerid][pName]);

    // Enable player spectating mode to hide class selection buttons ([<] [>] [Spawn])
    TogglePlayerSpectating(playerid, true);

    // Let's send a query to receive all the stored player data from the 'players' table.
    new szQuery[256];
    mysql_format(dbHandle, szQuery, sizeof (szQuery), "SELECT * FROM `players` WHERE `Name` = '%e' LIMIT 1", pData[playerid][pName]);
    mysql_tquery(dbHandle, szQuery, "OnPlayerAccountCheck", "i", playerid);

    // Set login status to false.
    pData[playerid][pLoggedIn] = false;

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    // It is not possible to get the player's last position in OnPlayerDisconnect if the client crashed.
    // Now, we're gonna get the player's pos and angle before we save the player data.
    // if(reason == 1)
    // {
    //     GetPlayerPos(playerid, pData[playerid][player_pos_x], pData[playerid][player_pos_y], pData[playerid][player_pos_z]);
    //     GetPlayerFacingAngle(playerid, pData[playerid][player_pos_angle]);
    // }

    GetPlayerPos(playerid, pData[playerid][player_pos_x], pData[playerid][player_pos_y], pData[playerid][player_pos_z]);
    GetPlayerFacingAngle(playerid, pData[playerid][player_pos_angle]);

    pData[playerid][pBadLogins] = 0;

    // Save the player data.
    SavepData(playerid);
    DestroyHBE(playerid);

    return 1;
}

public OnPlayerAccountCheck(playerid)
{
    if(cache_num_rows() > 0)
    {
        // An account exists with that name.
        cache_get_value(0, "hash", pData[playerid][PasswordHash]);

        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Log in", "This account (%s) is registered. Please enter your password in the field below:", "Login", "Cancel", pData[playerid][pName]);
    }
    else
    {
        // That name is not registered. Player needs to register.
        ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", "Welcome %s, you can register by entering your password in the field below:", "Register", "Cancel", pData[playerid][pName]);
    }

    return 1;
}



public OnPlayerHashPassword(playerid)
{
    new hash[BCRYPT_HASH_LENGTH];
    bcrypt_get_hash(hash, sizeof (hash));

    RegisterAccountForPlayer(playerid, hash);

    return 1;
}

RegisterAccountForPlayer(playerid, const hash [])
{
    new szQuery[256];
    pData[playerid][pSkin]             = DEFAULT_SKIN;
    pData[playerid][player_pos_x]      = DEFAULT_POS_X;
    pData[playerid][player_pos_y]      = DEFAULT_POS_Y;
    pData[playerid][player_pos_z]      = DEFAULT_POS_Z;
    pData[playerid][player_pos_angle]  = DEFAULT_POS_A;
    // mysql_format(dbHandle, szQuery, sizeof (szQuery), "INSERT INTO `players` (`name`, `hash`) VALUES ('%e', '%s')", pData[playerid][pName], hash);

    mysql_format(dbHandle, szQuery, sizeof(szQuery), "INSERT INTO `players` (`name`, `hash`, `skin`, `score`, `x_pos`, `y_pos`, `z_pos`, `angle_pos`) VALUES ('%e', '%e', '%i', '0', '%f', '%f', '%f', '%f')", pData[playerid][pName], hash, pData[playerid][pSkin], pData[playerid][player_pos_x], pData[playerid][player_pos_y], pData[playerid][player_pos_z], pData[playerid][player_pos_angle]);
    mysql_tquery(dbHandle, szQuery, "OnPlayerFinishRegistration", "i", playerid);

    return 1;
}

public OnPlayerFinishRegistration(playerid)
{
    // Retrieves the ID generated for an AUTO_INCREMENT column by the sent query
    new szQuery[256];
    pData[playerid][pAccountID] = cache_insert_id();

    // default values
    // pData[playerid][pSkin]             = DEFAULT_SKIN;
    // pData[playerid][player_pos_x]      = DEFAULT_POS_X;
    // pData[playerid][player_pos_y]      = DEFAULT_POS_Y;
    // pData[playerid][player_pos_z]      = DEFAULT_POS_Z;
    // pData[playerid][player_pos_angle]  = DEFAULT_POS_A;

    // mysql_format(dbHandle, regQuery, sizeof(regQuery), "INSERT INTO `players` (`ID`, `name`, `skin`, `score`, `x_pos`, `y_pos`, `z_pos`, `angle_pos`) VALUES ('%i', '%e', '%i', '0', '%f', '%f', '%f', '%f')", pData[playerid][pAccountID], pData[playerid][pName], pData[playerid][pSkin], pData[playerid][player_pos_x], pData[playerid][player_pos_y], pData[playerid][player_pos_z], pData[playerid][player_pos_angle]);
    // mysql_tquery(dbHandle, regQuery);

    // // Default skin
    // pData[playerid][pSkin]             = DEFAULT_SKIN;
    // SavepData(playerid);

    mysql_format(dbHandle, szQuery, sizeof (szQuery), "SELECT * FROM `players` WHERE `Name` = '%e' LIMIT 1", pData[playerid][pName]);
    mysql_tquery(dbHandle, szQuery, "OnPlayerAccountCheck", "i", playerid);

    // ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Registration", "Account successfully registered, and you have been automatically logged in.", "Close", "");

    // ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Log in", "This account (%s) is registered. Please enter your password in the field below:", "Login", "Cancel", pData[playerid][pName]);

    // pData[playerid][pLoggedIn] = true;

    // // It's the player's first spawn, so we're going to be using the default spawns we have defined.
    // pData[playerid][player_pos_x]      = DEFAULT_POS_X;
    // pData[playerid][player_pos_y]      = DEFAULT_POS_Y;
    // pData[playerid][player_pos_z]      = DEFAULT_POS_Z;
    // pData[playerid][player_pos_angle]  = DEFAULT_POS_A;

    // // Default skin
    // pData[playerid][pSkin]             = DEFAULT_SKIN;


    // // We initially set this to true in OnPlayerConnect to enable spectating mode. 
    // // Now that the player has registered, set it to false so they can control their character.
    // TogglePlayerSpectating(playerid, false);

    // // Set the player spawn info such as (Skin, pos, etc...)
    // SetSpawnInfo(playerid, NO_TEAM, pData[playerid][pSkin], pData[playerid][player_pos_x], pData[playerid][player_pos_y], pData[playerid][player_pos_z], pData[playerid][player_pos_angle], WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);

    // // Spawn the player
    // SpawnPlayer(playerid);

    return 1;
}

public OnPlayerVerifyPassword(playerid, bool:success)
{
    if(!success)
    {
        // Password is wrong.
        pData[playerid][pBadLogins] ++;

        // Did the player exceed the maximum login attempts?
        if(pData[playerid][pBadLogins] >= MAX_FAIL_LOGINS)
        {
            // Yes! Kick them.
            DelayedKick(playerid, "Exceed maximum login attempts");

            return 1;
        }

        new attemptsleft = MAX_FAIL_LOGINS - pData[playerid][pBadLogins];
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Log in", "{FF0000}WRONG PASSWORD\n{FF0000}You have %i login attempts left\n\n{FFFFFF}Please enter the password for this account (%s) in the field below.", "Log in", "Close", attemptsleft, pData[playerid][pName]);

    }
    else
    {
        // Password is valid.
        new szQuery[256];
        mysql_format(dbHandle, szQuery, sizeof (szQuery), "SELECT * FROM `players` WHERE `name` = '%e' LIMIT 1", pData[playerid][pName]);
        mysql_tquery(dbHandle, szQuery, "LoadPlayerData", "i", playerid);

    }

    return 1;
}



public OnPlayerSpawn(playerid)
{
    SetPlayerPos(playerid, pData[playerid][player_pos_x], pData[playerid][player_pos_y], pData[playerid][player_pos_z]);
    SetPlayerFacingAngle(playerid, pData[playerid][player_pos_angle]);
    pData[playerid][pSpawned] = true;

    SetPlayerSkin(playerid, pData[playerid][pSkin]);

    GivePlayerMoney(playerid, pData[playerid][pMoney]);

    CreatePlayerTextdraw(playerid);
    ShowHBE(playerid, true);
    // SetTimerEx("SetHungerBar", 1000, true, "ii", playerid, pData[playerid][pHunger] - 2.0);
    // SetPlayerProgressBarValue(playerid, HungerBar[playerid], 21.0);


    return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
    // Increase deaths count.
    // pData[playerid][pDeaths] ++;

    // We check if the killerid is a valid playerid, otherwise OnPlayerDeath will throw array index out of bounds.
    // if(killerid != INVALID_PLAYER_ID)
    // {
    //     // Increase the player's kills
    //     pData[killerid][pKills] ++;
    // }

    return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if (result == -1){
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Unknown command.");
        return 0;
    }
    return 1;
}

public TIMER_DelayedKick(playerid)
{
    Kick(playerid);

    return 1;
}