static char g_spawnClassName[][] = {"", "", "info_player_allies", "info_player_axis"};

void UseCase_InitSpawnPointPools() {
    InitSpawnPointPool(TEAM_ALLIES);
    InitSpawnPointPool(TEAM_AXIS);
}

static void InitSpawnPointPool(int team) {
    int spawnAmount = CountSpawnPoints(team);

    SpawnPointPool_Init(team, spawnAmount);
}

static int CountSpawnPoints(int team) {
    int amount = 0;
    int entity = INVALID_ENT_REFERENCE;

    while (FindSpawnPoint(entity, g_spawnClassName[team])) {
        amount++;
    }

    return amount;
}

static bool FindSpawnPoint(int& entity, const char[] className) {
    entity = FindEntityByClassname(entity, className);

    return entity != INVALID_ENT_REFERENCE;
}
