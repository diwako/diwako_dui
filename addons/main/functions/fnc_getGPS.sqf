#include "script_component.hpp"
params ["_unit"];

private _array = (assignedItems _unit) arrayIntersect GVAR(gpsWhitelist);
_array param [0, ""];
