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
    detour.Enable(Hook_Pre, OnSelectSpawnSpot);

    delete detour;
}

static MRESReturn OnSelectSpawnSpot(int client, DHookParam params) {
    int team = GetClientTeam(client);
    int lastSpawnIndex = SpawnPointPool_GetRandomIndex(team);

    params.SetObjectVar(2, 0, ObjectValueType_Int, lastSpawnIndex);

    return MRES_ChangedHandled;
}
