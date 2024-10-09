#include "script_component.hpp"

if !(hasInterface) exitWith {};

call FUNC(cacheLoop);

player setVariable [QGVAR(name), name player];
player setVariable [QGVAR(groupName), groupId (group player)];

// Create UI
([QUOTE(ADDON)] call BIS_fnc_rscLayer) cutRsc [QUOTE(ADDON), "PLAIN", 1, false];

private _ctrl = (uiNamespace getVariable ["diwako_dui_RscNametags", displayNull]) displayCtrl IDC_NAMETAG;

GVAR(lastUpdateTime) = time;

GVAR(pfhID) = [{ call FUNC(onDraw) }, 0.1, _ctrl] call CBA_fnc_addPerframeHandler;
