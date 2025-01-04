CMD:agivemoney(playerid, params[]){
    // if(pData(playerid, pAdmin) == 0) return PermissionError(playerid);
    if(pData[playerid][pAdmin] < 6) return PermissionError(playerid);

    new to, amount;
    if(sscanf(params, "ui", to, amount)){
        pData[playerid][pMoney] += amount;
        Usage(playerid, "/agivemoney [id] [amount]");
        return 1;
    }
    AdminCMD(to, "Admin %s Has given you"GREEN" $%d.", pData[playerid][pName], amount);
    return GivePlayerMoneyEx(to, amount);
}

// CMD:veh(playerid, params[]){
//     static
//         model[32],
//         color1,
//         color2;

//     if(pData[playerid][pAdmin] < 2)
//         return PermissionError(playerid);

//     if(sscanf(params, "s[32]I(0)I(0)", model, color1, color2))
//         return Usage(playerid, "/veh [model id/name] <color 1> <color 2>");

//     // if((model[0] = GetVehicleModelByName(model)) == 0)
//     //     return Error(playerid, "Invalid model ID.");

//     static
//         Float:x,
//         Float:y,
//         Float:z,
//         Float:a,
//         vehicleid;

//     GetPlayerPos(playerid, x, y, z);
//     GetPlayerFacingAngle(playerid, a);

//     vehicleid = CreateVehicle(model[0], x, y, z, a, color1, color2, 600);
// 	// AdminVehicle{vehicleid} = true;

//     if(GetPlayerInterior(playerid) != 0)
//         LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));

//     if(GetPlayerVirtualWorld(playerid) != 0)
//         SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));

//     if(Vehicle_IsBoat(vehicleid) || Vehicle_IsPlane(vehicleid) || Vehicle_IsHelicopter(vehicleid))
//         PutPlayerInVehicle(playerid, vehicleid, 0);

//     SetVehicleNumberPlate(vehicleid, "STATIC");
//     // Servers(playerid, "Anda memunculkan %s (%d, %d).", Model_GetName(model[0]), color1, color2);
//     return 1;
// }

CMD:veh(playerid, params[]){
    static Float:x,
        Float:y,
        Float:z,
        Float:a,
        vehicleid;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    vehicleid = CreateVehicle(562, x, y, z, a, 0, 0, 600);
    new str[50];
    format(str, sizeof(str), "You have spawned a vehicle with ID: %d.", vehicleid);
    AdminCMD(playerid, "You spawned a vehicle");
    return 1;
}