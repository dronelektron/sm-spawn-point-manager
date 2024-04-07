static ConVar g_shuffling;
static ConVar g_shufflingPause;

void Variable_Create() {
    g_shuffling = CreateConVar("sm_spawnpointmanager_shuffling", "1", "Enable (1) or disable (0) spawn points shuffling");
    g_shufflingPause = CreateConVar("sm_spawnpointmanager_shuffling_pause", "1", "Pause (in seconds) after shuffling");
}

bool Variable_Shuffling() {
    return g_shuffling.IntValue == 1;
}

int Variable_ShufflingPause() {
    return g_shufflingPause.IntValue;
}
