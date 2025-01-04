ptask UpdateHunger[1000](playerid){
    if(pData[playerid][pLoggedIn] == true){
        printf("Hunger: %d", pData[playerid][pHunger]);
        SetHungerBar(playerid, pData[playerid][pHunger] - 1);
    }
}

