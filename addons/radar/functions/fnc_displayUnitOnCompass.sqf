#include "script_component.hpp"
params [
    ["_unit", objNull],
    "_display",
    ["_viewDir", 0],
    ["_playerDir", 0],
    "_player",
    "_ctrlGrp"
];
if (isNull _unit) exitWith {};

private _namespace = missionNamespace;
private _unitID = _unit getVariable ["diwako_dui_unit_id",nil];
if (isNil "_unitID") then {
    _unitID = (_namespace getVariable ["diwako_dui_lastID", 0])+1;
    _namespace setVariable ["diwako_dui_lastID", _unitID];
    _unit setVariable ["diwako_dui_unit_id", _unitID];
};

if (isNil "_player") then {
    _player = [] call CBA_fnc_currentUnit;
};

private _circleRange = diwako_dui_compassRange;
private _distance = _player distance2d _unit;
private _alpha = 0;
private _relDir = 0;
if (_distance <= _circleRange) then {
    _alpha = linearConversion [_circleRange * 0.90, _circleRange, _distance, diwako_dui_compass_opacity, 0, true];
    _relDir = ((_player getRelDir _unit) - (_viewDir - _playerDir) ) mod 360;
};

if (diwako_dui_enable_occlusion && {_alpha > 0}) then {
    private _lastSeen = _unit getVariable QGVAR(lastSeen);
    private _occlusionAlpha = _alpha;
    private _occlude = !isNil "_lastSeen";
    if (_unit getVariable ["diwako_dui_lastChecked", -1] < time) then {
        private _delay = [1,0.2] select (_namespace getVariable[QEGVAR(indicators,show), true]);

        _unit setVariable ["diwako_dui_lastChecked", time + _delay];
        private _vis = [vehicle _unit, "VIEW"] checkVisibility [eyePos _player,  AGLToASL (_unit modelToWorld (_unit selectionPosition "Spine2"))];
        private _cone = if (_relDir > 180) then { abs (_relDir - 360)} else { abs _relDir};
        if (_vis == 0 || {GVAR(enable_occlusion_actual_cone) < _cone}) then {
            _occlude = true;
        } else {
            // unit visible
            if !(isNil "_lastSeen") then {
                _unit setVariable [QGVAR(lastSeen), nil];
            };
            _occlude = false;
        };
    };
    if (_occlude) then {
        // unit not visible anymore
        if (isNil "_lastSeen") then {
            _lastSeen = time;
            _unit setVariable [QGVAR(lastSeen), _lastSeen];
        };
        _alpha = linearConversion [0, GVAR(occlusion_fade_time), time - _lastSeen, 1, 0, true] min _alpha;
        _occlusionAlpha = _alpha;
    } else {
        _occlusionAlpha = 1;
    };
    _unit setVariable [QGVAR(occlusion_alpha), _occlusionAlpha];
};

private _ctrl = _ctrlGrp getVariable [format ["diwako_dui_ctrl_unit_%1", _unitID], controlNull];

if (_alpha <= 0) exitWith {
    if (isNull _ctrl) exitWith {controlNull};
    ctrlDelete _ctrl;
    controlNull
};

private _dir = -(_viewDir - (getDir _unit)) mod 360;
private _divisor = linearConversion [35,50,_circleRange,2.25,2.75,false] / diwako_dui_hudScaling; //2.25;

if (isNull _ctrl) then {
    _ctrl = _display ctrlCreate ["RscPicture", -1, _ctrlGrp];
    _ctrlGrp setVariable [format ["diwako_dui_ctrl_unit_%1", _unitID], _ctrl];

    private _ctrlArr = _ctrlGrp getVariable ["ctrl_diw_ctrlArr", nil];
    if (isNil "_ctrlArr") then {
        _ctrlArr = [];
        _ctrlGrp setVariable ["ctrl_diw_ctrlArr", _ctrlArr];
    };
    _ctrlArr pushBack _ctrl;
};

ctrlPosition _ctrlGrp params ["_left", "_top", "_width", "_height"];
private _dist = _distance / linearConversion [15,50,_circleRange,40,145,false];
private _iconScale = diwako_dui_compass_icon_scale * (_unit getVariable [QGVAR(icon_size), 1]);
private _newWidth = (44 * pixelW) /_divisor * _iconScale;
private _newHeight = (44 * pixelH) /_divisor * _iconScale;

_ctrl ctrlSetPosition [
    _width/2 + _width * (sin _relDir * _dist) - _newWidth/2,
    _height/2 - _height * (cos _relDir * _dist) - _newHeight/2,
    _newWidth,
    _newHeight
];
_ctrl ctrlSetAngle [_dir,0.5,0.5,false];
_ctrl ctrlCommit 0;

private _color = [0.85, 0.4, 0];
if (_distance > diwako_dui_distanceWarning || {!(isNull objectParent _unit) || {_unit == _player}}) then {
    _color = + (_unit getVariable [QGVAR(compass_color), [1,1,1]]);
};
_color pushBack _alpha;
_ctrl ctrlSetTextColor _color;
_ctrl ctrlSetText (_unit getVariable [QGVAR(compass_icon), DUI_RIFLEMAN]);

_ctrl
