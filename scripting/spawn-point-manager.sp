#include <sourcemod>
#include <sdktools>

#include "spawn-point-manager/spawn-point-list"
#include "spawn-point-manager/use-case"

#include "modules/console-variable.sp"
#include "modules/entity.sp"
#include "modules/event.sp"
#include "modules/spawn-point-list.sp"
#include "modules/use-case.sp"

#define AUTO_CREATE_YES true

public Plugin myinfo = {
    name = "Spawn point manager",
    author = "Dron-elektron",
    description = "Allows you to perform various actions with spawn points",
    version = "0.1.1",
    url = "https://github.com/dronelektron/spawn-point-manager"
};

public void OnPluginStart() {
    Variable_Create();
    Event_Create();
    SpawnPointList_Create();
    AutoExecConfig(AUTO_CREATE_YES, "spawn-point-manager");
}

public void OnMapStart() {
    UseCase_ClearSpawnPointLists();
    UseCase_FindSpawnPoints();
}
