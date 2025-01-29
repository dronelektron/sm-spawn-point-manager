static Handle g_timers[LISTS_AMOUNT];

void Timer_Reset(int list) {
    g_timers[list] = null;
}

void Timer_ResetSpawnPointPool(int list) {
    if (g_timers[list] == null) {
        g_timers[list] = CreateTimer(TIMER_DELAY, OnResetSpawnPointPool, list, TIMER_FLAGS);
    }
}

static Action OnResetSpawnPointPool(Handle timer, int list) {
    SpawnPointPool_ResetCurrentIndex(list);
    Timer_Reset(list);

    return Plugin_Continue;
}
