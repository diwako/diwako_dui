#include "script_component.hpp"

params ["", "_pfhHandle"];

if (!isGameFocused || isGamePaused) exitWith {};

if !(GVAR(syncRunning)) exitWith {
    // stop pfh and remove any synced group arrays
    [_pfhHandle] call CBA_fnc_removePerFrameHandler;
    GVAR(syncPFH) = nil;
    private _grp = [];
    {
        _grp = _x getVariable QGVAR(syncGroup);
        if !(isNil "_grp") then {
            _x setVariable [QGVAR(syncGroup), nil, true];
        };
    } forEach allGroups;
};

// get all alive player units
private _players = ((call CBA_fnc_players) select {alive _x}) - allCurators;

// get all groups containing players
private _groups = [];
{
    _groups pushBackUnique (group _x);
} forEach _players;

// sync groups if the units array in them changed
private _grp = [];
{
    _grp = units _x;
    if (_grp isNotEqualTo (_x getVariable [QGVAR(syncGroup), []])) then {
        _x setVariable [QGVAR(syncGroup), _grp, true];
    };
} forEach _groups;
