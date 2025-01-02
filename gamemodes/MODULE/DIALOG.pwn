public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_REGISTER:
        {
            // We kick the players that have clicked the 'Cancel' button.
            if(!response) return Kick(playerid);

            // the password must be greater than 5 characters.
            if(strlen(inputtext) <= 5)
            {
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration",
                "{FF0000}Your password must be longer than 5 characters!\n\
                {FFFFFF}Please enter your password in the field below:",
                "Register", "Cancel");
            }
            else
            {
                // Password is good. Hash it.
                bcrypt_hash(playerid, "OnPlayerHashPassword", inputtext, BCRYPT_COST);
            }
        }

        case DIALOG_LOGIN:
        {
            // We kick the players that have clicked the 'Cancel' button.
            if(!response) return Kick(playerid);

            // We're gonna check and see if the password is correct.
            bcrypt_verify(playerid, "OnPlayerVerifyPassword", inputtext, pData[playerid][PasswordHash]);
        }
    }

    return 1;
}