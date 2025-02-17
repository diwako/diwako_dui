#include "..\script_component.hpp"

[{ call FUNC(cacheLoop); }, [], 0.5] call CBA_fnc_waitAndExecute;

private _player = call CBA_fnc_currentUnit;

private _canShow = [_player] call EFUNC(main,canHudBeShown);

if (!_canShow || !GVAR(Enabled)) exitWith {
    if (GVAR(CompassShown)) then {
        call FUNC(HideCompass);
    };
};

if (_canShow && GVAR(Enabled)) then {
    if (!GVAR(CompassShown)) then {
        call FUNC(ShowCompass);
    };
};

if (GVAR(CompassAvailableShown) && {floor(time % 1) == 0}) then {
    if (!GVAR(CompassShown) && { [_player] call EFUNC(main,getCompass) isNotEqualTo "" }) then {
        call FUNC(ShowCompass);
    } else {
        if (GVAR(CompassShown) && { [_player] call EFUNC(main,getCompass) isEqualTo "" }) then {
            call FUNC(HideCompass);
        };
    };
};

if (customWaypointPosition isNotEqualTo GVAR(customWaypointPosition)) then {
    if (customWaypointPosition isEqualTo []) then {
        "CUSTOM_WAYPOINT_POSITION" call FUNC(removeLineMarker);
    } else {
        ["CUSTOM_WAYPOINT_POSITION", customWaypointPosition, GVAR(CustomWaypointColor)] call FUNC(addLineMarker);
    };
    GVAR(customWaypointPosition) = customWaypointPosition;
};


private _unitsToRender = units group _player;
if !(isNil "diwako_dui_special_track" && { diwako_dui_special_track isEqualType [] }) then {
    _unitsToRender append diwako_dui_special_track;
};

GVAR(RenderData) = _unitsToRender apply {

    ([_x, _player] call FUNC(getUnitIcon)) params [["_icon", "a3\ui_f\data\map\Markers\Military\dot_ca.paa", [""]], ["_size", 2, [0]]];
    _size = [PX(_size), PY(_size)];

    private _color = +(_x getVariable [QEGVAR(main,compass_color), [1, 1, 1]]);
    if (_color isEqualTo [1, 1, 1]) then {
        _color = +GVAR(DefaultIconColor);
    };

    [
        _x,
        _color,
        _icon,
        _size
    ];

};

private _dialog = uiNamespace getVariable QGVAR(Compass);
if (!isNull _dialog) then {

    private _parentControl = _dialog displayCtrl CONTAINER_IDC;
    _parentControl ctrlSetPosition [GET_POS_X, GET_POS_Y, GET_POS_W, GET_POS_H];
    _parentControl ctrlCommit 0;

    private _yPosNum = [0.6, 2] select GVAR(SwapOrder);
    private _yPos = PY(_yPosNum);

    for "_i" from 0 to 108 do {

        private _ctrl = _dialog displayCtrl (LINE_IDC_START + _i);
        private _pos = ctrlPosition _ctrl;
        _pos set [1, _yPos];
        _ctrl ctrlSetPosition _pos;
        _ctrl ctrlCommit 0;
    };


    _yPosNum = [2, 0.3] select GVAR(SwapOrder);
    _yPos = PY(_yPosNum);

    for "_i" from 0 to 36 do {

        private _ctrl = _dialog displayCtrl (BEARING_IDC_START + _i);
        private _pos = ctrlPosition _ctrl;
        _pos set [1, _yPos];
        _ctrl ctrlSetPosition _pos;
        _ctrl ctrlCommit 0;
    };

    private _ctrl = _dialog displayCtrl NEEDLE_IDC;

    private _pos = ctrlPosition _ctrl;
    _pos set [1, [PY(1.6), PY(3)] select GVAR(SwapOrder)];
    _ctrl ctrlSetPosition _pos;
    _ctrl ctrlCommit 0;

};
