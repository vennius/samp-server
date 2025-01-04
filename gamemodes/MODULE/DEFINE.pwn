// Default spawn point we're gonna be using. Los Santos Airport.
#define     DEFAULT_POS_X       1643.7200
#define     DEFAULT_POS_Y       -2245.2900
#define     DEFAULT_POS_Z       13.4873
#define     DEFAULT_POS_A       187.2000

// Default skin
#define     DEFAULT_SKIN        188

// The maximum attempts a player has --> Kick the player at 3.
#define MAX_FAIL_LOGINS     3

#define DEFAULT_WEAPON 22

// #define GivePlayerMoney GivePlayerMoneyEx

#define Servers(%1,%2) SendClientMessage(%1, ARWIN, "[SERVER]: "WHITE""%2)
#define Info(%1,%2) SendClientMessage(%1, ARWIN, "[INFO]: "WHITE""%2)
#define Vehicle(%1,%2) SendClientMessage(%1, ARWIN, "[VEHICLE]: "WHITE""%2)
#define Usage(%1,%2) SendClientMessage(%1, ARWIN , "[USAGE]: "WHITE""%2)
#define Error(%1,%2) SendClientMessage(%1, HEX_GREY3, ""RED"[ERROR]: "WHITE""%2)
#define AdminCMD(%1,%2) SendClientMessage(%1, HEX_RED , "[ADMIN]: "WHITE""%2)
#define Gps(%1,%2) SendClientMessage(%1, HEX_GREY3, ""HEX_GPS"[GPS]: "WHITE""%2)
#define PermissionError(%0) SendClientMessage(%0, HEX_RED, "[ERROR]: "WHITE"Kamu tidak memiliki akses untuk melakukan command ini!")
