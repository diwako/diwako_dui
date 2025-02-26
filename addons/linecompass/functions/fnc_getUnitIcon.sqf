#include "..\script_component.hpp"

params ["_unit", "_player"];

if !(_unit isNil QGVAR(customIcon)) exitWith {
    _unit getVariable QGVAR(customIcon);
};

private _icon = "a3\ui_f\data\map\Markers\Military\dot_ca.paa";
private _size = 3.6;

if (leader _unit == _unit) then {
    _icon = "a3\ui_f\data\gui\cfg\ranks\corporal_gs.paa";
    _size = 1.3;
};

if (_unit getUnitTrait "medic" || _unit getVariable ["ace_medical_medicClass", 0] != 0) then {
    _icon = "a3\ui_f\data\map\vehicleicons\pictureheal_ca.paa";
    _size = 2;
};

// Buddy
if (_player == (_unit getVariable [QEGVAR(buddy,buddy), objNull])) then {
    _icon = QPATHTOF(UI\buddy_dot.paa);
    _size = 1.6;
};

[_icon, _size];
