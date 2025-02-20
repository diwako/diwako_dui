#include "script_component.hpp"
params ["_unit"];

private _array = (assignedItems _unit) arrayIntersect GVAR(compassWhitelist);
_array param [0, ""];
