void Event_Create() {
    HookEvent("dod_round_start", Event_RoundStart);
    HookEvent("player_spawn", Event_PlayerSpawn);
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
    UseCase_FindSpawnPoints();
}

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast) {
    UseCase_ShuffleSpawnPoints();
}
