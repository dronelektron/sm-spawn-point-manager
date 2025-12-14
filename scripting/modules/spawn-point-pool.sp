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
    return GetRandomIndex(g_indices[team], g_currentIndex[team]);
}

static int GetRandomIndex(ArrayList indices, int& current) {
    int pivot = GetRandomInt(current, indices.Length - 1);
    int index = indices.Get(pivot);

    indices.SwapAt(current, pivot);
    current++;

    if (current == indices.Length) {
        current = 0;
    }

    return index;
}
