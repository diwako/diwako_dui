#include "script_component.hpp"

[{ call FUNC(cacheLoop); }, [], 1] call CBA_fnc_waitAndExecute;

if (!GVAR(enabled)) exitWith {
    if (GVAR(pfhID) isNotEqualTo -1) then {
        GVAR(pfhID) call CBA_fnc_removePerframeHandler;
        GVAR(pfhID) = -1;
        ([QUOTE(ADDON)] call BIS_fnc_rscLayer) cutFadeOut 0;
    };
};

if (GVAR(pfhID) isEqualTo -1) then {
    ([QUOTE(ADDON)] call BIS_fnc_rscLayer) cutRsc [QUOTE(ADDON), "PLAIN", 1, false];
    private _ctrl = (uiNamespace getVariable ["diwako_dui_RscNametags", displayNull]) displayCtrl IDC_NAMETAG;
    GVAR(pfhID) = [{ call FUNC(onDraw) }, 0.1, _ctrl] call CBA_fnc_addPerframeHandler;
};

private _rankNamesHashMap = GVAR(RankNames) get GVAR(rankNameStyle);

{
    if (alive _x) then {
        _x setVariable [QGVAR(name), _x getVariable [QEGVAR(main,customName), _x getVariable ["ACE_Name", name _x]]];
        _x setVariable [QGVAR(groupName), _x getVariable [QGVAR(customGroup), groupId (group _x)]];
        _x setVariable [QGVAR(side), side group _x];
        private _rank = rank _x;
        private _rankName = _rankNamesHashMap get _rank;
        if (isNil "_rankName") then {
            _rankName = (GVAR(RankNames) get "default") get _rank;
        };
        _x setVariable [QGVAR(rank), _rankName];
    };
} forEach allUnits;
