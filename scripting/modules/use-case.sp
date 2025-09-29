static char g_spawnClassName[][] = {"", "", "info_player_allies", "info_player_axis"};
static int g_spawnAmount[TEAM_AXIS + 1] = {0, ...};

void UseCase_CountSpawnPoints() {
    CountSpawnPoints(TEAM_ALLIES);
    CountSpawnPoints(TEAM_AXIS);
}

static void CountSpawnPoints(int team) {
    g_spawnAmount[team] = 0;

    int entity = INVALID_ENT_REFERENCE;

    while (FindSpawnPoint(entity, g_spawnClassName[team])) {
        g_spawnAmount[team]++;
    }
}

static bool FindSpawnPoint(int& entity, const char[] className) {
    entity = FindEntityByClassname(entity, className);

    return entity != INVALID_ENT_REFERENCE;
}

int UseCase_GetRandomSpawnIndex(int client) {
    int team = GetClientTeam(client);
    int lastIndex = g_spawnAmount[team] - 1;

    return GetRandomInt(0, lastIndex);
}
