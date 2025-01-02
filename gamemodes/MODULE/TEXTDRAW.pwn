new Text: TD_Time[MAX_PLAYERS][1];

CreatePlayerTextdraw(playerid){
  // TIME
  TD_Time[playerid][0] = TextDrawCreate(5.000, 430.000, "");
  TextDrawLetterSize(TD_Time[playerid][0], 0.300, 1.500);
  TextDrawTextSize(TD_Time[playerid][0], 167.000, 0.000);
  TextDrawAlignment(TD_Time[playerid][0], 1);
  TextDrawColor(TD_Time[playerid][0], -190553857);
  TextDrawSetShadow(TD_Time[playerid][0], 1);
  TextDrawSetOutline(TD_Time[playerid][0], 1);
  TextDrawBackgroundColor(TD_Time[playerid][0], 150);
  TextDrawFont(TD_Time[playerid][0], 2);
  TextDrawSetProportional(TD_Time[playerid][0], true);
  TextDrawShowForPlayer(playerid, TD_Time[playerid][0]);
}