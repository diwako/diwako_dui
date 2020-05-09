#include "script_component.hpp"

if (!isServer || {missionNamespace getVariable [QGVAR(syncRunning), false]}) exitWith {};

GVAR(syncRunning) = true;
// loop
GVAR(syncPFH) = [GVAR(fnc_syncGroupsPFH), 2, [] ] call CBA_fnc_addPerFrameHandler;
