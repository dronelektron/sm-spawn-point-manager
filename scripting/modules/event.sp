void Event_Create() {
    HookEvent("player_spawn", Event_PlayerSpawn);
}

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast) {
    UseCase_ShuffleSpawnPoints();
}
