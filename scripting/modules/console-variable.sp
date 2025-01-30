static ConVar g_randomization;

void Variable_Create() {
    g_randomization = CreateConVar("sm_spawnpointmanager_randomization", "1", "Randomization of spawn points");
}

bool Variable_Randomization() {
    return g_randomization.BoolValue;
}
