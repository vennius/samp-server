forward LoadPlayerData(playerid);
public LoadPlayerData(playerid)
{
    // Reset the bad login attempts
    pData[playerid][pBadLogins] = 0;


    cache_get_value_name_int(0, "ID", pData[playerid][pAccountID]);

    cache_get_value_name_int(0, "skin", pData[playerid][pSkin]);
    cache_get_value_name_int(0, "score", pData[playerid][pScore]);

    cache_get_value_name_float(0, "x_pos", pData[playerid][player_pos_x]);
    cache_get_value_name_float(0, "y_pos", pData[playerid][player_pos_y]);
    cache_get_value_name_float(0, "z_pos", pData[playerid][player_pos_z]);
    cache_get_value_name_float(0, "angle_pos", pData[playerid][player_pos_angle]);
    cache_get_value_name_int(0, "admin", pData[playerid][pAdmin]);
    cache_get_value_name_int(0, "money", pData[playerid][pMoney]);
    cache_get_value_name_int(0, "hunger", pData[playerid][pHunger]);
    cache_get_value_name_int(0, "thirst", pData[playerid][pThirst]);

    // ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Login", "You have been successfully logged in.", "Close", "");

    // We initially set this to true in OnPlayerConnect to enable spectating mode. 
    // Now that the player has logged in, set it to false so they can control their character.
    TogglePlayerSpectating(playerid, false);

    // Player score
    SetPlayerScore(playerid, pData[playerid][pScore]);

    // Set the player spawn info.
    SetSpawnInfo(playerid, NO_TEAM, pData[playerid][pSkin], pData[playerid][player_pos_x], pData[playerid][player_pos_y], pData[playerid][player_pos_z], pData[playerid][player_pos_angle], WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);
    
    // Spawn the player.
    SpawnPlayer(playerid);

    // Player is logged in now.
    pData[playerid][pLoggedIn] = true;

    return 1;
}
