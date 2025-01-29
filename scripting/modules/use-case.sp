static char g_spawnPointClassName[][] = {
    "info_player_allies",
    "info_player_axis"
};

void UseCase_FindSpawnPoints() {
    FindSpawnPoints(List_Allies);
    FindSpawnPoints(List_Axis);
}

static void FindSpawnPoints(int list) {
    SpawnPointList_Clear(list);
    SpawnPointPool_Clear(list);

    int entity = INDEX_NOT_FOUND;

    while (FindSpawnPoint(entity, list)) {
        SpawnPointList_Add(list, entity);
    }

    int amount = SpawnPointList_Size(list);

    SpawnPointPool_Init(list, amount);
    SpawnPointPool_ResetCurrentIndex(list);
}

static bool FindSpawnPoint(int& entity, int list) {
    entity = FindEntityByClassname(entity, g_spawnPointClassName[list]);

    return entity != INDEX_NOT_FOUND;
}

void UseCase_SelectRandomSpawnPoint(int client) {
    int team = GetClientTeam(client);

    if (team < TEAM_ALLIES) {
        return;
    }

    int list = team - TEAM_ALLIES;
    int entity = GetRandomSpawnPoint(client, list);

    if (entity > INDEX_NOT_FOUND) {
        TeleportPlayerToSpawnPoint(client, entity);
    }

    Timer_ResetSpawnPointPool(list);
}

static int GetRandomSpawnPoint(int client, int list) {
    int attempts = SpawnPointList_Size(list);

    for (int i = 0; i < attempts; i++) {
        int index = SpawnPointPool_GetIndex(list);
        int entity = SpawnPointList_Get(list, index);

        if (IsSpawnPointOccupied(entity, client)) {
            continue;
        }

        return entity;
    }

    return INDEX_NOT_FOUND;
}

static void TeleportPlayerToSpawnPoint(int client, int entity) {
    float position[3];
    float angles[3];

    Entity_GetPosition(entity, position);
    Entity_GetAngles(entity, angles);
    TeleportEntity(client, position, angles);
}

static bool IsSpawnPointOccupied(int entity, int client) {
    float position[3];
    float mins[3];
    float maxs[3];

    Entity_GetPosition(entity, position);
    GetClientMins(client, mins);
    GetClientMaxs(client, maxs);
    TR_TraceHullFilter(position, position, mins, maxs, MASK_ALL, EnemiesOnly, client);

    return TR_DidHit();
}

static bool EnemiesOnly(int entity, int contentsMask, int client) {
    return IsClient(entity) && FromOtherTeam(client, entity);
}

static bool IsClient(int entity) {
    return 1 <= entity && entity <= MaxClients;
}

static bool FromOtherTeam(int client, int target) {
    int clientTeam = GetClientTeam(client);
    int targetTeam = GetClientTeam(target);

    return clientTeam != targetTeam;
}
