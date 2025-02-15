#include "..\script_component.hpp"

params ["_unit"];

if !(isNil {_unit getVariable QGVAR(UnitIcon)}) exitWith {
    _unit getVariable QGVAR(UnitIcon);
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

[_icon, _size];
