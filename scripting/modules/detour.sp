static DynamicDetour g_shufflingDetour;
static bool g_shufflingEnabled;

void Detour_Create() {
    GameData gameData = OpenGameData("spawn-point-manager.games");

    SelectSpawnSpot_Create(gameData);

    delete gameData;
}

void Detour_SelectSpawnSpot_CheckConfig() {
    bool enabled = Variable_Shuffling();

    Detour_SelectSpawnSpot_Toggle(enabled);
}

void Detour_SelectSpawnSpot_Toggle(bool enabled) {
    if (g_shufflingEnabled == enabled) {
        return;
    }

    g_shufflingEnabled = enabled;

    if (enabled) {
        g_shufflingDetour.Enable(Hook_Pre, OnSelectSpawnSpot);
    } else {
        g_shufflingDetour.Disable(Hook_Pre, OnSelectSpawnSpot);
    }
}

static GameData OpenGameData(const char[] name) {
    GameData gameData = new GameData(name);

    if (gameData == null) {
        SetFailState("Unable to open the '%s' game data", name);
    }

    return gameData;
}

static void SelectSpawnSpot_Create(GameData gameData) {
    g_shufflingDetour = DHookCreateDetour(Address_Null, CallConv_THISCALL, ReturnType_Void, ThisPointer_CBaseEntity);
    g_shufflingDetour.SetFromConf(gameData, SDKConf_Signature, "CDODPlayer::SelectSpawnSpot");
    g_shufflingDetour.AddParam(HookParamType_ObjectPtr); // spawnPoints
    g_shufflingDetour.AddParam(HookParamType_ObjectPtr); // lastSpawnIndex
}

static MRESReturn OnSelectSpawnSpot(int client, DHookParam params) {
    int team = GetClientTeam(client);
    int lastSpawnIndex = SpawnPointPool_GetRandomIndex(team);

    params.SetObjectVar(2, 0, ObjectValueType_Int, lastSpawnIndex);

    return MRES_ChangedHandled;
}
