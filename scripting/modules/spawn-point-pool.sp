static ArrayList g_indices[TEAM_AXIS + 1];
static int g_currentIndex[TEAM_AXIS + 1];

void SpawnPointPool_Create() {
    g_indices[TEAM_ALLIES] = new ArrayList();
    g_indices[TEAM_AXIS] = new ArrayList();
}

void SpawnPointPool_Init(int team, int spawnAmount) {
    g_indices[team].Clear();
    g_currentIndex[team] = 0;

    for (int i = 0; i < spawnAmount; i++) {
        g_indices[team].Push(i);
    }
}

int SpawnPointPool_GetRandomIndex(int team) {
    int amount = g_indices[team].Length;
    int current = g_currentIndex[team];

    if (current == amount - 1) {
        g_currentIndex[team] = 0;

        return g_indices[team].Get(current);
    }

    int pivot = GetRandomInt(current + 1, amount - 1);
    int index = g_indices[team].Get(pivot);

    g_indices[team].SwapAt(current, pivot);
    g_currentIndex[team]++;

    return index;
}
