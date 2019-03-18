#include "script_component.hpp"

// loop
[FUNC(cacheLoop),[],0.5] call CBA_fnc_waitAndExecute;

if (GVAR(show)) then {
    if (GVAR(drawEh) < 0) then {
        GVAR(drawEh) = addMissionEventHandler ["Draw3D", {
            call FUNC(display);
        }];
    };

    private _player = [] call CBA_fnc_currentUnit;
    private _indicatorNamespace = missionNamespace getVariable format[QGVAR(indicator_%1), GVAR(style)];

    private _innerIcon = "";
    {
        _innerIcon = _x getVariable [QGVAR(icon), ""];
        if (_innerIcon isEqualTo "") then {
            if (_x isEqualTo (_player getVariable [QEGVAR(radar,buddy), objNull])) then {
                _innerIcon = _indicatorNamespace getVariable ["buddy", ""];
            } else {
                if (_x isEqualTo (leader group _player)) then {
                    _innerIcon = _indicatorNamespace getVariable ["leader", ""];
                } else {
                    if (_x getVariable ["ace_medical_medicClass", [0, 1] select (_x getUnitTrait "medic")] > 0) then {
                        _innerIcon = _indicatorNamespace getVariable ["medic", ""];
                    };
                };
            };
        };
        _x setVariable [QGVAR(outerIcon), _indicatorNamespace getVariable ["indicator", ""]];
        _x setVariable [QGVAR(innerIcon), _innerIcon];
    } forEach ((units (group _player)) - [_player]);
} else {
    if (GVAR(drawEh) >= 0) then {
        removeMissionEventHandler ["Draw3D", GVAR(drawEh)];
        GVAR(drawEh) = -1;
    };
};
