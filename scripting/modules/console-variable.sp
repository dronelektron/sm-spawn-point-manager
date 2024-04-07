static ConVar g_shuffling;

void Variable_Create() {
    g_shuffling = CreateConVar("sm_spawnpointmanager_shuffling", "1", "Enable (1) or disable (0) spawn points shuffling");
}

bool Variable_Shuffling() {
    return g_shuffling.IntValue == 1;
}
