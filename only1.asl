// Thanks to Earllgray and Peas for testing the ASL
state("SMBBBHD")
{
    int isNotLoading : "mono-2.0-bdwgc.dll", 0x0039B56C, 0x794, 0x90, 0x2C; // This was found by Ellie (Elisiah)
    int splitter : "UnityPlayer.dll", 0x01099D78, 0x4, 0x8, 0x1C, 0xBC, 0x18, 0x30; // Based on time bonus value after finishing each level, turns to null in main menu
}

init
{
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = true;
    vars.trigger = false;
    vars.comparison = null;
}

update
{
    // Splits when the score is updated from 0 after level completion (not on bonuses)
    if ((current.splitter != old.splitter) && (current.splitter != 0) && (old.splitter != null) && (current.splitter != null) && (current.splitter != vars.comparison))
    {
        vars.trigger = true;
    }
}

split
{
    if (vars.trigger == true)
    {
        vars.comparison = current.splitter;
        vars.trigger = false;
        return true;
    }
}

isLoading
{
    return current.isNotLoading != 1;
}
