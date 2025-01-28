static ArrayList g_entities[LISTS_AMOUNT];

void SpawnPointList_Create() {
    g_entities[List_Allies] = new ArrayList();
    g_entities[List_Axis] = new ArrayList();
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
