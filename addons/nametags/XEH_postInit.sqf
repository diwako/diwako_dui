#include "script_component.hpp"

if !(hasInterface) exitWith {};

GVAR(targetedFade) = 1;

call FUNC(cacheLoop);

player setVariable [QGVAR(name), name player];
player setVariable [QGVAR(groupName), groupID (group player)];
private _rank = rank player;
private _index = (GVAR(RankNames) select 0) find _rank;
if (_index isNotEqualTo -1) then {
    _rank = (GVAR(RankNames) select 1) select _index;
};
player setVariable [QGVAR(rank), _rank];

// Create UI
([QUOTE(ADDON)] call BIS_fnc_rscLayer) cutRsc [QUOTE(ADDON), "PLAIN", 1, false];

private _ctrl = (uiNamespace getVariable ["diwako_dui_RscNametags", displayNull]) displayCtrl IDC_NAMETAG;

GVAR(lastUpdateTime) = time;

GVAR(pfhID) = [{ call FUNC(onDraw) }, 0.1, _ctrl] call CBA_fnc_addPerframeHandler;
GVAR(RankNames) = [["PRIVATE","CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN","MAJOR","COLONEL"], ["Pvt", "Cpl", "Sgt", "Lt", "Capt", "Maj", "Col"]];
