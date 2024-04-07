static int g_lastShuffleTime;

static char g_spawnPointClassName[][] = {
    "info_player_allies",
    "info_player_axis"
};

void UseCase_ClearSpawnPointLists() {
    SpawnPointList_Clear(LIST_ALLIES);
    SpawnPointList_Clear(LIST_AXIS);
}

void UseCase_FindSpawnPoints() {
    FindSpawnPoints(LIST_ALLIES);
    FindSpawnPoints(LIST_AXIS);
}

static void FindSpawnPoints(int list) {
    SpawnPointList_Clear(list);

    int entity = INDEX_NOT_FOUND;

    while (FindSpawnPoint(entity, list)) {
        SpawnPointList_Add(list, entity);
    }
}

static bool FindSpawnPoint(int& entity, int list) {
    entity = FindEntityByClassname(entity, g_spawnPointClassName[list]);

    return entity != INDEX_NOT_FOUND;
}

void UseCase_ShuffleSpawnPoints() {
    if (Variable_Shuffling() && IsShufflingReady()) {
        ShuffleSpawnPoints(LIST_ALLIES);
        ShuffleSpawnPoints(LIST_AXIS);
    }
}

static bool IsShufflingReady() {
    int shuffleTime = GetTime();
    int secondsPassed = shuffleTime - g_lastShuffleTime;

    if (secondsPassed < Variable_ShufflingPause()) {
        return false;
    }

    g_lastShuffleTime = shuffleTime;

    return true;
}

static void ShuffleSpawnPoints(int list) {
    for (int i = SpawnPointList_Size(list) - 1; i > 0; i--) {
        int j = GetRandomInt(0, i - 1);

        SwapSpawnPoints(list, i, j);
    }
}

static void SwapSpawnPoints(int list, int index1, int index2) {
    int entity[POINTS_AMOUNT];
    float position[POINTS_AMOUNT][3];
    float angles[POINTS_AMOUNT][3];

    GetSpawnPointState(list, index1, entity[POINT_FIRST], position[POINT_FIRST], angles[POINT_FIRST]);
    GetSpawnPointState(list, index2, entity[POINT_SECOND], position[POINT_SECOND], angles[POINT_SECOND]);

    TeleportEntity(entity[POINT_FIRST], position[POINT_SECOND], angles[POINT_SECOND]);
    TeleportEntity(entity[POINT_SECOND], position[POINT_FIRST], angles[POINT_FIRST]);
}

static void GetSpawnPointState(int list, int index, int& entity, float position[3], float angles[3]) {
    entity = SpawnPointList_Get(list, index);

    Entity_GetPosition(entity, position);
    Entity_GetAngles(entity, angles);
}
