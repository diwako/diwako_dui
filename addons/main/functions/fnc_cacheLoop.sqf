#include "script_component.hpp"

// loop
[FUNC(cacheLoop),[],0.5] call CBA_fnc_waitAndExecute;

private _colorNameSpace = missionNamespace getVariable format[QGVAR(colors_%1), diwako_dui_colors];

{
    if (alive _x) then {
        // when remote controling a an AI assign can return nil
        private _assignedTeam = [assignedTeam _x] param [0, "MAIN"];

        _x setVariable [QGVAR(color), _colorNameSpace getVariable [_assignedTeam, "#FFFFFF"]];
        _x setVariable [QGVAR(compass_color), _colorNameSpace getVariable [(format ["%1_compass", _assignedTeam]), [1,1,1]]];
    };
} forEach (units ([] call CBA_fnc_currentUnit));

private _specialTrack = missionNamespace getVariable ["diwako_dui_special_track", []];
if (_specialTrack isEqualType [] && {_specialTrack isNotEqualTo []}) then {
    private _trackingcolor = GVAR(trackingColor) select [0, 3];
    {
        _x setVariable [QGVAR(compass_color), _trackingcolor];
    } forEach _specialTrack;
};
