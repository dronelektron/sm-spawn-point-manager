static ArrayList g_entities[LIST_AXIS + 1];

void SpawnPointList_Create() {
    g_entities[LIST_ALLIES] = new ArrayList();
    g_entities[LIST_AXIS] = new ArrayList();
}

void SpawnPointList_Clear(int list) {
    g_entities[list].Clear();
}

void SpawnPointList_Add(int list, int entity) {
    g_entities[list].Push(entity);
}

int SpawnPointList_Get(int list, int index) {
    return g_entities[list].Get(index);
}

int SpawnPointList_Size(int list) {
    return g_entities[list].Length;
}
