#include "script_component.hpp"
params ["_unit1", "_unit2", ["_assign", true]];

if !(isNull (_unit1 getVariable [QGVAR(buddy), objNull])) then {
    (_unit1 getVariable [QGVAR(buddy), objNull]) setVariable [QGVAR(buddy), nil, true];
};
if !(isNull (_unit2 getVariable [QGVAR(buddy), objNull])) then {
    (_unit2 getVariable [QGVAR(buddy), objNull]) setVariable [QGVAR(buddy), nil, true];
};

if (_assign) then {
    _unit1 setVariable [QGVAR(buddy), _unit2, true];
    _unit2 setVariable [QGVAR(buddy), _unit1, true];
} else {
    _unit1 setVariable [QGVAR(buddy), nil, true];
    _unit2 setVariable [QGVAR(buddy), nil, true];
};
