#include "script_component.hpp"
params ["_unit"];

private _array = (assignedItems _unit) arrayIntersect GVAR(gpsWhitelist);
if (_array isNotEqualTo []) exitWith {
    _array select 0
};
""
