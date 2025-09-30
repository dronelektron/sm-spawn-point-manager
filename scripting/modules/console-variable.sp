static ConVar g_shuffling;

void Variable_Create() {
    g_shuffling = CreateConVar("sm_spawnpointmanager_shuffling", "1", "Shuffle spawn points");
    g_shuffling.AddChangeHook(OnShuffling);
}

bool Variable_Shuffling() {
    return g_shuffling.BoolValue;
}

static void OnShuffling(ConVar variable, const char[] oldValue, const char[] newValue) {
    Detour_SelectSpawnSpot_CheckConfig();
}
