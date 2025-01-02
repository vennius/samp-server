CMD:help(playerid, params[])
{
    SendClientMessage(playerid, 0xFFFFFFFF, "Welcome to the server!");
    SendClientMessage(playerid, 0xFFFFFFFF, "Commands:");
    SendClientMessage(playerid, 0xFFFFFFFF, "/help - Displays this message.");
    SendClientMessage(playerid, 0xFFFFFFFF, "/register - Register an account.");
    SendClientMessage(playerid, 0xFFFFFFFF, "/login - Log in to your account.");
    SendClientMessage(playerid, 0xFFFFFFFF, "/logout - Log out of your account.");
    SendClientMessage(playerid, 0xFFFFFFFF, "/stats - Display your stats.");
    return 1;
}

CMD:stats(playerid, params[]){
    new caption[50], info[200];
    format(caption, sizeof(caption), "%s's Stats", pData[playerid][pName]);
        format(info, sizeof(info), RED_D"In Character"WHITE"\n");
        format(info, sizeof(info), "%sName: [%s] | Money: [%s]""\n", info, pData[playerid][pName], 1000);
    
    ShowPlayerDialog(playerid, DIALOG_STATS, DIALOG_STYLE_MSGBOX, caption, info, "Close", "");
    return 1;
}