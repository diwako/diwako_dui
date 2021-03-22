#include "script_component.hpp"

[{ call FUNC(cacheLoop); }, [], 1] call CBA_fnc_waitAndExecute;

if (!GVAR(enabled)) exitWith {
    if (GVAR(pfhID) != -1) then {
        GVAR(pfhID) call CBA_fnc_removePerframeHandler;
        GVAR(pfhID) = -1;
        ([QUOTE(ADDON)] call BIS_fnc_rscLayer) cutFadeOut 0;
    };
};

if (GVAR(pfhID) == -1) then {
    ([QUOTE(ADDON)] call BIS_fnc_rscLayer) cutRsc [QUOTE(ADDON), "PLAIN", 1, false];
    private _ctrl = (uiNamespace getVariable ["diwako_dui_RscNametags", displayNull]) displayCtrl IDC_NAMETAG;
    GVAR(pfhID) = [{ call FUNC(onDraw) }, 0.1, _ctrl] call CBA_fnc_addPerframeHandler;
};

{
    if (alive _x) then {
        _x setVariable [QGVAR(name), name _x];
        _x setVariable [QGVAR(groupName), _x getVariable [QGVAR(customGroup), groupID (group _x)]];
        _x setVariable [QGVAR(side), side group _x];
        private _rank = rank _x;
        private _index = (GVAR(RankNames) select 0) find _rank;
        if (_index != -1) then {
            _rank = (GVAR(RankNames) select 1) select _index;
        };
        _x setVariable [QGVAR(rank), _rank];
    };
} forEach allUnits;
