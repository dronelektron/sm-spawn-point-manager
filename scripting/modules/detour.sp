void Detour_Create() {
    GameData gameData = OpenGameData("spawn-point-manager.games");

    SelectSpawnSpot_Create(gameData);

    delete gameData;
}

static GameData OpenGameData(const char[] name) {
    GameData gameData = new GameData(name);

    if (gameData == null) {
        SetFailState("Unable to open the '%s' game data", name);
    }

    return gameData;
}

static void SelectSpawnSpot_Create(GameData gameData) {
    DynamicDetour detour = DHookCreateDetour(Address_Null, CallConv_THISCALL, ReturnType_Void, ThisPointer_CBaseEntity);

    detour.SetFromConf(gameData, SDKConf_Signature, "CDODPlayer::SelectSpawnSpot");
    detour.AddParam(HookParamType_ObjectPtr); // spawnPoints
    detour.AddParam(HookParamType_ObjectPtr); // lastSpawnIndex
    detour.Enable(Hook_Post, OnSelectSpawnSpot);

    delete detour;
}

static MRESReturn OnSelectSpawnSpot(int client, DHookParam params) {
    int lastSpawnIndex = params.GetObjectVar(2, 0, ObjectValueType_Int);

    PrintToServer("[DEBUG] OnSelectSpawnSpot: player %N, last spawn index %d", client, lastSpawnIndex);

    return MRES_Ignored;
}
