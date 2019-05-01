#include "script_component.hpp"
params ["_unit"];

private _compass = "";
private _items = assignedItems _unit;
private _whitelist = GVAR(compassWhitelist);
private _compass = "";
private _possibleCompasses = [];
private _count = count _items;

if (_count > 1) then {
    _possibleCompasses = [toLower (_items select 1), toLower (_items select 0)];
} else {
    if (_count == 1) then {
        _possibleCompasses pushBack (toLower (_items select 0));
    };
};

{
    if (_whitelist find _x != -1) exitWith {
        _compass = _x;
    };
} forEach _possibleCompasses;

_compass
