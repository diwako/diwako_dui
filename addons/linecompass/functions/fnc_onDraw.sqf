#include "..\script_component.hpp"


// Exit if the compass is not visible
private _dialog = uiNamespace getVariable QGVAR(Compass);
if (isNull _dialog) exitWith {};

private _viewDirectionVector = (positionCameraToWorld [0, 0, 0]) vectorDiff (positionCameraToWorld [0, 0, -1]);
private _viewDirection = ((_viewDirectionVector select 0) atan2 (_viewDirectionVector select 1) + 360) % 360;
private _currentPosition = getPosVisual player;

// Shift the control group to view direction
private _control = _dialog displayCtrl 7100;
_control ctrlSetPosition [PX(_viewDirection * -0.5), PY(1)];
_control ctrlCommit 0;

// Alpha
private _lineAngleOffset = 2.5 - (_viewDirection % 5);
private _lineIndexVisibilityOffset = floor (_viewDirection / 5);

for "_i" from 0 to 37 do {
    private _idc = _i + _lineIndexVisibilityOffset;
    private _control = _dialog displayCtrl (7101 + _idc);
    private _newAlpha = (_i * 5 + _lineAngleOffset) call FUNC(getAlphaFromX);
    private _oldAlpha = GVAR(lineAlphaCache) select _idc;

    if (_newAlpha != _oldAlpha) then {
        GVAR(lineAlphaCache) set [_idc, _newAlpha];
        _control ctrlSetTextColor [1, 1, 1, _newAlpha];
        _control ctrlCommit 0;
    };
};

private _bearingOffset = 2.5 - (_viewDirection % 15);
for "_i" from 0 to 13 do {

    private _idc = _i + floor (_viewDirection / 15);
    private _control = _dialog displayCtrl (7301 + _idc);
    private _newAlpha = (_i * 15 + _bearingOffset) call FUNC(getAlphaFromX);
    private _oldAlpha = GVAR(bearingAlphaCache) select _idc;

    switch (GVAR(DrawBearing)) do {
        case 1: {
            private _idcMod = _idc mod 3;
            if (_idcMod != 0) then {
                _newAlpha = 0;
            };
            break;
        };
        case 2: {
            _newAlpha = 0;
            break;
        };
    };

    if (_newAlpha != _oldAlpha) then {
        GVAR(bearingAlphaCache) set [_idc, _newAlpha];
        _control ctrlSetTextColor [1, 1, 1, _newAlpha];
        _control ctrlCommit 0;
    };
};

// Line marker
private _nextLineMarkerControl = 0;
private _overlapCacheLineIndices = [];

{
    _y params ["_color", "_markerPosition"];

    private _relativeVectorToMarker = _markerPosition vectorDiff _currentPosition;
    private _angleToMarker = ((_relativeVectorToMarker select 0) atan2 (_relativeVectorToMarker select 1) + 360) % 360;

    private _control = GVAR(lineMarkerControlPool) select _nextLineMarkerControl;
    if (isNil "_control" || {isNull _control}) then {
        _control = _dialog ctrlCreate ["RscPicture", 7401 + _nextLineMarkerControl, _dialog displayCtrl 7100];
        _control ctrlSetText "#(argb,8,8,3)color(1,1,1,1)";
        GVAR(lineMarkerControlPool) set [_nextLineMarkerControl, _control];
    };

    private _lineIndex = floor (_angleToMarker / 5) + 18;
    if (_viewDirection >= 270 && _lineIndex < 36) then {
        _lineIndex = _lineIndex + 72;
    };
    if (_viewDirection <= 90 && _lineIndex > 72) then {
        _lineIndex = _lineIndex - 72;
    };

    private _offset = (_angleToMarker % 5) - 2.5;
    _control setVariable [QGVAR(color), _color];
    _control setVariable [QGVAR(offset), _offset];
    _control setVariable [QGVAR(lineIndex), _lineIndex];

    // Shift
    private _otherMarkerControl = _overlapCacheLineIndices param [_lineIndex, nil];
    if !(isNil "_otherMarkerControl") then {
        // Compare
        private _otherOffset = _otherMarkerControl getVariable QGVAR(offset);
        if (abs _otherOffset < abs _offset) then {
            // Swap
            _offset = _otherOffset;
            private _tmp = _otherMarkerControl;
            _otherMarkerControl = _control;
            _control = _tmp;
        } else {
            _overlapCacheLineIndices set [_lineIndex, _control];
        };

        // Direction
        private _shiftDirection = if (_offset == 0) then {
            1
        } else {
            _offset / abs _offset // 1 or -1
        };

        // Shift
        private _shiftedLineIndex = _lineIndex;

        while {!isNil "_otherMarkerControl"} do {
            _shiftedLineIndex = _shiftedLineIndex + _shiftDirection;
            _otherMarkerControl setVariable [QGVAR(lineIndex), _shiftedLineIndex];

            private _tmp = _otherMarkerControl;
            _otherMarkerControl = _overlapCacheLineIndices param [_shiftedLineIndex, nil];
            _overlapCacheLineIndices set [_shiftedLineIndex, _tmp];
        };
    } else {
        _overlapCacheLineIndices set [_lineIndex, _control];
    };

    _nextLineMarkerControl = _nextLineMarkerControl + 1;

} forEach GVAR(lineMarkers);

// Remove the unused controls
if (_nextLineMarkerControl < count GVAR(lineMarkerControlPool)) then {
    for "_i" from _nextLineMarkerControl to (count GVAR(lineMarkerControlPool) - 1) do {
        ctrlDelete (GVAR(lineMarkerControlPool) deleteAt _nextLineMarkerControl);
    };
};

{
    if (ctrlShown _x) then {

        private _lineIndex = _x getVariable QGVAR(lineIndex);
        private _color = _x getVariable QGVAR(color);
        private _alpha = (2.5 + ((_lineIndex - floor (_viewDirection / 5)) * 5) - (_viewDirection % 5)) call FUNC(getAlphaFromX);

        _x ctrlSetPosition [PX(_lineIndex * 2.5 + 0.15), PY(0.6), PX(2.2), PY(0.3)];
        _x ctrlSetTextColor [_color select 0, _color select 1, _color select 2, (_color select 3) * _alpha];
        _x ctrlCommit 0;
    };
} forEach GVAR(lineMarkerControlPool);

// Icon marker
private _nextIconMarkerControl = 0;

private _player = call CBA_fnc_currentUnit;

private _units = units group _player;
if !(isNil "diwako_dui_special_track" && { diwako_dui_special_track isEqualType [] }) then {
    _units append diwako_dui_special_track;
};

{
    _x params ["_unit", "_color", "_icon", "_size"];

    // Check if the unit is not the player himself and alive.
    if (alive _unit && _unit != _player && (isNull objectParent _player || {!(_unit in crew objectParent _player)})) then {
        private _unitPosition = getPosVisual _unit;
        private _relativeVectorToUnit = _unitPosition vectorDiff _currentPosition;
        private _angleToUnit = ((_relativeVectorToUnit select 0) atan2 (_relativeVectorToUnit select 1) + 360) % 360;

        private _control = GVAR(iconMarkerControlPool) select _nextIconMarkerControl;
        if (isNil "_control" || {isNull _control}) then {
            _control = _dialog ctrlCreate ["RscPicture", 7501 + _nextIconMarkerControl, _dialog displayCtrl 7100];
            GVAR(iconMarkerControlPool) set [_nextIconMarkerControl, _control];
        };

        _control ctrlSetShadow GVAR(IconOutline);

        private _compassAngle = _angleToUnit + 90;
        if (_viewDirection >= 270 && _compassAngle < 180) then {
            _compassAngle = _compassAngle + 360;
        };
        if (_viewDirection <= 90 && _compassAngle > 360) then {
            _compassAngle = _compassAngle - 360;
        };

        _control ctrlSetText _icon;

        _color set [3, ((1 - 0.2 * ((_player distance _unit) - (diwako_dui_compassRange - 6))) min 1) * ((_compassAngle - _viewDirection) call FUNC(getAlphaFromX)) min 1];
        _control ctrlSetTextColor _color;

        private _positionCenter = [PX(_compassAngle * 0.5) - ((_size select 0) / 2), PY(0.75) - ((_size select 1) / 2)];
        _positionCenter append _size;
        _control ctrlSetPosition _positionCenter;

        _control ctrlCommit 0;

        _nextIconMarkerControl = _nextIconMarkerControl + 1;
    };

} forEach GVAR(RenderData);

if (_nextIconMarkerControl < count GVAR(iconMarkerControlPool)) then {
    for "_i" from _nextIconMarkerControl to (count GVAR(iconMarkerControlPool) - 1) do {
        ctrlDelete (GVAR(iconMarkerControlPool) deleteAt _nextIconMarkerControl);
    };
};
