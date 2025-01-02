stock GivePlayerMoneyEx(playerid, amount){
  if(amount < 0) return 0;
  pData[playerid][pMoney] += amount;
  return GivePlayerMoney(playerid, amount);
}