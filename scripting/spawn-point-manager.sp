#include <sourcemod>
#include <dhooks>

#include "spawn-point-manager/client"

#include "modules/console-variable.sp"
#include "modules/detour.sp"
#include "modules/spawn-point-pool.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Spawn point manager",
    author = "Dron-elektron",
    description = "Allows you to perform various actions with spawn points",
    version = "0.3.0",
    url = "https://github.com/dronelektron/spawn-point-manager"
};

public void OnPluginStart() {
    Variable_Create();
    Detour_Create();
    SpawnPointPool_Create();
    AutoExecConfig(_, "spawn-point-manager");
    Detour_SelectSpawnSpot_CheckConfig();
}

public void OnMapStart() {
    UseCase_InitSpawnPointPools();
}
