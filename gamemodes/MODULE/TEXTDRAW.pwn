new PlayerText:PlayerTD[MAX_PLAYERS][3];
new PlayerText:HUD_BG[MAX_PLAYERS];
new PlayerText:HUD_Model[MAX_PLAYERS];
new PlayerText:Percent_HP[MAX_PLAYERS];
new PlayerBar:HungerBar[MAX_PLAYERS];
new PlayerBar:ThirstBar[MAX_PLAYERS];

CreatePlayerTextdraw(playerid){
  HUD_BG[playerid] = CreatePlayerTextDraw(playerid, 585.000000, 347.000000, "_");
  PlayerTextDrawFont(playerid, HUD_BG[playerid], 1);
  PlayerTextDrawLetterSize(playerid, HUD_BG[playerid], 0.670831, 11.100006);
  PlayerTextDrawTextSize(playerid, HUD_BG[playerid], 301.500000, 111.000000);
  PlayerTextDrawSetOutline(playerid, HUD_BG[playerid], 1);
  PlayerTextDrawSetShadow(playerid, HUD_BG[playerid], 0);
  PlayerTextDrawAlignment(playerid, HUD_BG[playerid], 2);
  PlayerTextDrawColor(playerid, HUD_BG[playerid], -1);
  PlayerTextDrawBackgroundColor(playerid, HUD_BG[playerid], 255);
  PlayerTextDrawBoxColor(playerid, HUD_BG[playerid], 135);
  PlayerTextDrawUseBox(playerid, HUD_BG[playerid], 1);
  PlayerTextDrawSetProportional(playerid, HUD_BG[playerid], 1);
  PlayerTextDrawSetSelectable(playerid, HUD_BG[playerid], 0);

  HUD_Model[playerid] = CreatePlayerTextDraw(playerid, 441.000000, 345.500000, "Preview_Model");
  PlayerTextDrawFont(playerid, HUD_Model[playerid], 5);
  PlayerTextDrawLetterSize(playerid, HUD_Model[playerid], 0.600000, 2.000000);
  PlayerTextDrawTextSize(playerid, HUD_Model[playerid], 87.500000, 103.000000);
  PlayerTextDrawSetOutline(playerid, HUD_Model[playerid], 0);
  PlayerTextDrawSetShadow(playerid, HUD_Model[playerid], 0);
  PlayerTextDrawAlignment(playerid, HUD_Model[playerid], 1);
  PlayerTextDrawColor(playerid, HUD_Model[playerid], -1);
  PlayerTextDrawBackgroundColor(playerid, HUD_Model[playerid], 125);
  PlayerTextDrawBoxColor(playerid, HUD_Model[playerid], 255);
  PlayerTextDrawUseBox(playerid, HUD_Model[playerid], 0);
  PlayerTextDrawSetProportional(playerid, HUD_Model[playerid], 1);
  PlayerTextDrawSetSelectable(playerid, HUD_Model[playerid], 0);
  PlayerTextDrawSetPreviewModel(playerid, HUD_Model[playerid], 0);
  PlayerTextDrawSetPreviewRot(playerid, HUD_Model[playerid], -10.000000, 0.000000, -20.000000, 1.000000);
  PlayerTextDrawSetPreviewVehCol(playerid, HUD_Model[playerid], 1, 1);

  PlayerTD[playerid][0] = CreatePlayerTextDraw(playerid, 531.000000, 361.000000, "HUD:radar_burgershot");
  PlayerTextDrawFont(playerid, PlayerTD[playerid][0], 4);
  PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][0], 0.600000, 2.000000);
  PlayerTextDrawTextSize(playerid, PlayerTD[playerid][0], 12.000000, 13.000000);
  PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][0], 1);
  PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][0], 0);
  PlayerTextDrawAlignment(playerid, PlayerTD[playerid][0], 1);
  PlayerTextDrawColor(playerid, PlayerTD[playerid][0], -1);
  PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][0], 255);
  PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][0], 50);
  PlayerTextDrawUseBox(playerid, PlayerTD[playerid][0], 1);
  PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][0], 1);
  PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][0], 0);

  PlayerTD[playerid][1] = CreatePlayerTextDraw(playerid, 533.000000, 392.000000, "HUD:radar_diner");
  PlayerTextDrawFont(playerid, PlayerTD[playerid][1], 4);
  PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][1], 0.600000, 2.000000);
  PlayerTextDrawTextSize(playerid, PlayerTD[playerid][1], 12.000000, 13.000000);
  PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][1], 1);
  PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][1], 0);
  PlayerTextDrawAlignment(playerid, PlayerTD[playerid][1], 1);
  PlayerTextDrawColor(playerid, PlayerTD[playerid][1], -1);
  PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][1], 255);
  PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][1], 50);
  PlayerTextDrawUseBox(playerid, PlayerTD[playerid][1], 1);
  PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][1], 1);
  PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][1], 0);

  Percent_HP[playerid] = CreatePlayerTextDraw(playerid, 542.000000, 434.000000, "100");
  PlayerTextDrawFont(playerid, Percent_HP[playerid], 2);
  PlayerTextDrawLetterSize(playerid, Percent_HP[playerid], 0.274998, 1.249997);
  PlayerTextDrawTextSize(playerid, Percent_HP[playerid], 400.000000, 17.000000);
  PlayerTextDrawSetOutline(playerid, Percent_HP[playerid], 1);
  PlayerTextDrawSetShadow(playerid, Percent_HP[playerid], 0);
  PlayerTextDrawAlignment(playerid, Percent_HP[playerid], 2);
  PlayerTextDrawColor(playerid, Percent_HP[playerid], -16776961);
  PlayerTextDrawBackgroundColor(playerid, Percent_HP[playerid], 255);
  PlayerTextDrawBoxColor(playerid, Percent_HP[playerid], 50);
  PlayerTextDrawUseBox(playerid, Percent_HP[playerid], 0);
  PlayerTextDrawSetProportional(playerid, Percent_HP[playerid], 1);
  PlayerTextDrawSetSelectable(playerid, Percent_HP[playerid], 0);

  PlayerTD[playerid][2] = CreatePlayerTextDraw(playerid, 536.000000, 422.000000, "HUD:radar_girlfriend");
  PlayerTextDrawFont(playerid, PlayerTD[playerid][2], 4);
  PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][2], 0.600000, 2.000000);
  PlayerTextDrawTextSize(playerid, PlayerTD[playerid][2], 10.500000, 12.500000);
  PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][2], 1);
  PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][2], 0);
  PlayerTextDrawAlignment(playerid, PlayerTD[playerid][2], 1);
  PlayerTextDrawColor(playerid, PlayerTD[playerid][2], -1);
  PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][2], 255);
  PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][2], 50);
  PlayerTextDrawUseBox(playerid, PlayerTD[playerid][2], 1);
  PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][2], 1);
  PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][2], 0);


  /*Player Progress Bars
  Requires "progress2" include by Southclaws
  Download: https://github.com/Southclaws/progress2/releases */
  HungerBar[playerid] = CreatePlayerProgressBar(playerid, 533.000000, 375.000000, 70.500000, 10.000000, -65281, 100.0, 0);
  SetPlayerProgressBarValue(playerid, HungerBar[playerid], 0);

  ThirstBar[playerid] = CreatePlayerProgressBar(playerid, 535.000000, 408.000000, 69.000000, 10.000000, -1378294017, 100.0, 0);
  SetPlayerProgressBarValue(playerid, ThirstBar[playerid], 0);
  return 1;
}

ShowHBE(playerid, bool:show){
  if(show){
    PlayerTextDrawShow(playerid, HUD_BG[playerid]);
    PlayerTextDrawShow(playerid, HUD_Model[playerid]);
    PlayerTextDrawShow(playerid, PlayerTD[playerid][0]);
    PlayerTextDrawShow(playerid, PlayerTD[playerid][1]);
    PlayerTextDrawShow(playerid, Percent_HP[playerid]);
    PlayerTextDrawShow(playerid, PlayerTD[playerid][2]);
    ShowPlayerProgressBar(playerid, HungerBar[playerid]);
    ShowPlayerProgressBar(playerid, ThirstBar[playerid]);
  }else{
    PlayerTextDrawHide(playerid, HUD_BG[playerid]);
    PlayerTextDrawHide(playerid, HUD_Model[playerid]);
    PlayerTextDrawHide(playerid, PlayerTD[playerid][0]);
    PlayerTextDrawHide(playerid, PlayerTD[playerid][1]);
    PlayerTextDrawHide(playerid, Percent_HP[playerid]);
    PlayerTextDrawHide(playerid, PlayerTD[playerid][2]);
    HidePlayerProgressBar(playerid, HungerBar[playerid]);
    HidePlayerProgressBar(playerid, ThirstBar[playerid]);
  }
  return 1;
}

DestroyHBE(playerid){
  PlayerTextDrawDestroy(playerid, HUD_BG[playerid]);
  PlayerTextDrawDestroy(playerid, HUD_Model[playerid]);
  PlayerTextDrawDestroy(playerid, PlayerTD[playerid][0]);
  PlayerTextDrawDestroy(playerid, PlayerTD[playerid][1]);
  PlayerTextDrawDestroy(playerid, Percent_HP[playerid]);
  PlayerTextDrawDestroy(playerid, PlayerTD[playerid][2]);
  DestroyPlayerProgressBar(playerid, HungerBar[playerid]);
  DestroyPlayerProgressBar(playerid, ThirstBar[playerid]);
  return 1;
}