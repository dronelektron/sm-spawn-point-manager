#include <sourcemod>
#include <sdktools>

#include "spawn-point-manager/spawn-point-list"
#include "spawn-point-manager/use-case"

#include "modules/entity.sp"
#include "modules/event.sp"
#include "modules/spawn-point-list.sp"
#include "modules/spawn-point-pool.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Spawn point manager",
    author = "Dron-elektron",
    description = "Allows you to perform various actions with spawn points",
    version = "0.2.0",
    url = "https://github.com/dronelektron/spawn-point-manager"
};

public void OnPluginStart() {
    Event_Create();
    SpawnPointList_Create();
    SpawnPointPool_Create();
}

public void OnMapStart() {
    UseCase_ResetLastSpawnTime();
    UseCase_FindSpawnPoints();
}
