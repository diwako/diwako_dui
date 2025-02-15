#include "..\script_component.hpp"

[{ call FUNC(cacheLoop);}, [], 0.1] call CBA_fnc_waitUntil;

if (EGVAR(main,toggled_off) || !GVAR(Enabled)) exitWith {
    if (GVAR(CompassShown)) then {
        call FUNC(HideCompass);
    };
};

if (EGVAR(main,toggled_off) || !GVAR(Enabled)) then {
    if (!GVAR(CompassShown)) then {
        call FUNC(ShowCompass);
    };
};

if (GVAR(CompassAvailableShown) && {floor(time % 1) == 0}) then {
    if (!GVAR(CompassShown) && { call EFUNC(main,getCompass) isNotEqualTo "" }) then {
        call FUNC(ShowCompass);
    } else {
        if (GVAR(CompassShown) && { call EFUNC(main,getCompass) isEqualTo "" }) then {
            call FUNC(HideCompass);
        };
    };
};

if (customWaypointPosition isNotEqualTo GVAR(customWaypointPosition)) then {
    if (customWaypointPosition isEqualTo []) then {
        "VANILLA_MOVE" call FUNC(removeLineMarker);
    } else {
        ["VANILLA_MOVE", GVAR(WaypointColor), customWaypointPosition] call FUNC(addLineMarker);
    };
    GVAR(customWaypointPosition) = customWaypointPosition;
};


private _unitsToRender = units group player;
if !(isNil "diwako_dui_special_track" && { diwako_dui_special_track isEqualType [] }) then {
    _unitsToRender append diwako_dui_special_track;
};

GVAR(RenderData) = _unitsToRender apply {

    (_x call FUNC(getUnitIcon)) params [["_icon", "a3\ui_f\data\map\Markers\Military\dot_ca.paa", [""]], ["_size", 2, [0]]];
    _size = [PX(_size), PY(_size)];
    private _color = +(_x getVariable [QEGVAR(main,compass_color), [1, 1, 1]]);
    if (_color isEqualTo [1, 1, 1]) then {
        _color = GVAR(DefaultIconColor);
    };
    [
        _x,
        _color,
        _icon,
        _size
    ];
};
