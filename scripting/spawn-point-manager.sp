#include <sourcemod>
#include <dhooks>

#include "spawn-point-manager/client"

#include "modules/detour.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Spawn point manager",
    author = "Dron-elektron",
    description = "Allows you to perform various actions with spawn points",
    version = "0.2.0",
    url = "https://github.com/dronelektron/spawn-point-manager"
};

public void OnPluginStart() {
    Detour_Create();
}

public void OnMapStart() {
    UseCase_CountSpawnPoints();
}
