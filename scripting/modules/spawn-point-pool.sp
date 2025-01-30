static ArrayList g_indices[LISTS_AMOUNT];
static int g_currentIndex[LISTS_AMOUNT];

void SpawnPointPool_Create() {
    g_indices[List_Allies] = new ArrayList();
    g_indices[List_Axis] = new ArrayList();
}

void SpawnPointPool_Clear(int list) {
    g_indices[list].Clear();
}

void SpawnPointPool_Init(int list, int amount) {
    for (int i = 0; i < amount; i++) {
        g_indices[list].Push(i);
    }
}

void SpawnPointPool_ResetCurrentIndex(int list) {
    g_currentIndex[list] = 0;
}

int SpawnPointPool_GetIndex(int list) {
    int amount = SpawnPointList_Size(list);
    int current = g_currentIndex[list];
    int start = current + 1;

    if (start < amount) {
        int end = amount - 1;
        int pivot = GetRandomInt(start, end);

        g_indices[list].SwapAt(current, pivot);
        g_currentIndex[list]++;
    } else {
        SpawnPointPool_ResetCurrentIndex(list);
    }

    return g_indices[list].Get(current);
}
