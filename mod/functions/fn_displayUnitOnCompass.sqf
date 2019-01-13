#include "../script_component.hpp"
params [
    ["_unit", objNull],
    "_display", 
    ["_viewDir", 0], 
    ["_playerDir", 0], 
    ["_player", [] call CBA_fnc_currentUnit], 
    "_ctrlGrp"
];
if (isNull _unit) exitWith {};

private _unitID = _unit getVariable ["diwako_dui_unit_id",nil];
if (isNil '_unitID') then {
    _unitID = (missionNamespace getVariable ["diwako_dui_lastID", 0])+1;
    missionNamespace setVariable ["diwako_dui_lastID", _unitID];
    _unit setVariable ["diwako_dui_unit_id", _unitID];
};

private _circleRange = diwako_dui_compassRange;
private _distance = _player distance2d _unit;
private _fade = linearConversion [_circleRange*0.90, _circleRange, _distance, 1, 0, true];

if (diwako_dui_enable_occlusion && {_fade > 0}) then {
    private _vis = [vehicle _unit, "VIEW"] checkVisibility [eyePos _player,  AGLToASL (_unit modelToWorld (_unit selectionPosition "Spine2"))];
    private _lastSeen = _unit getVariable "diwako_dui_lastSeen";

    if (_vis == 0) then {
        // unit not visible anymore
        if (isNil "_lastSeen") then {
            _lastSeen = time;
            _unit setVariable ["diwako_dui_lastSeen", _lastSeen];
        };
        _fade = linearConversion [0, 10, time - _lastSeen, 1, 0, true] min _fade;
    } else {
        // unit visible
        if !(isNil "_lastSeen") then {
            _unit setVariable ["diwako_dui_lastSeen", nil];
        };
    };
};

private _ctrl = _ctrlGrp getVariable [('diwako_dui_ctrl_unit_' + str _unitID), controlNull];

if (_fade <= 0) exitWith {
    if (isNull _ctrl) exitWith {controlNull};
    ctrlDelete _ctrl;
    controlNull
};

private _dir = -(_viewDir - (getDir _unit)) mod 360;
private _divisor = linearConversion [35,50,_circleRange,2.25,2.75,false]; //2.25;

if (isNull _ctrl) then {
    _ctrl = _display ctrlCreate ['RscPicture', -1, _ctrlGrp];
    _ctrlGrp setVariable [('diwako_dui_ctrl_unit_' + str _unitID), _ctrl];

    private _ctrlArr = _ctrlGrp getVariable ['ctrl_diw_ctrlArr', nil];
    if (isNil '_ctrlArr') then {
        _ctrlArr = [];
        _ctrlGrp setVariable ['ctrl_diw_ctrlArr', _ctrlArr];
    };
    _ctrlArr pushBack _ctrl;
};

ctrlPosition _ctrlGrp params ["_left", "_top", "_width", "_height"];
private _center = [_left + _width/2, _top + _height/2];
private _relDir = ((_player getRelDir _unit) - (_viewDir - _playerDir) ) mod 360;
private _dist = _distance / linearConversion [15,50,_circleRange,40,145,false];;
private _newWidth = (safeZoneW/40)/_divisor;
private _newHeight = (safeZoneH/25)/_divisor;
private _ctrlPos = [
    _width/2 + _width * (sin _relDir * _dist) - _newWidth/2,
    _height/2 - _height * (cos _relDir * _dist) - _newHeight/2,
    _newWidth,
    _newHeight
];

_ctrl ctrlSetPosition _ctrlPos;
_ctrl ctrlSetAngle [_dir,0.5,0.5,false];
_ctrl ctrlCommit 0;

private _color = [0.85, 0.4, 0];
if (_distance > 3 || {!(isNull objectParent _unit) || {_unit == _player}}) then {
    _color = + (_unit getVariable ["diwako_dui_compass_color", [1,1,1]]);
};
_color pushBack _fade;
_ctrl ctrlSetTextColor _color;
_ctrl ctrlSetText (_unit getVariable ["diwako_dui_compass_icon", DUI_RIFLEMAN]);

_ctrl
