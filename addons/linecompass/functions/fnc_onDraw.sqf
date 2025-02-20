#include "..\script_component.hpp"


// Exit if the compass is not visible
private _dialog = uiNamespace getVariable QGVAR(Compass);
if (isNull _dialog) exitWith {};

private _player = call CBA_fnc_currentUnit;

private _viewDirectionVector = getCameraViewDirection _player;
private _viewDirection = ((_viewDirectionVector select 0) atan2 (_viewDirectionVector select 1) + 360) % 360;
private _currentPosition = getPosVisual _player;

// Shift the control group to view direction
private _holderControl = _dialog displayCtrl HOLDER_IDC;
_holderControl ctrlSetPosition [PX(_viewDirection * -0.5), PY(1)];
_holderControl ctrlCommit 0;

// Alpha
private _lineAngleOffset = 2.5 - (_viewDirection % 5);
private _lineIndexVisibilityOffset = floor (_viewDirection / 5);

for "_i" from 0 to 37 do {
    private _idc = _i + _lineIndexVisibilityOffset;
    private _control = _dialog displayCtrl (LINE_IDC_START + _idc);
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
    private _control = _dialog displayCtrl (BEARING_IDC_START + _idc);
    private _newAlpha = (_i * 15 + _bearingOffset) call FUNC(getAlphaFromX);
    private _oldAlpha = GVAR(bearingAlphaCache) select _idc;

    switch (GVAR(DrawBearing)) do {
        case 0: {
            _newAlpha = 0;
        };
        case 1: {
            private _idcMod = _idc mod 3;
            if (_idcMod != 0) then {
                _newAlpha = 0;
            };
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
        _control = _dialog ctrlCreate ["RscPicture", 7401 + _nextLineMarkerControl, _holderControl];
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

private _yPos = [PY(0.6), PY(2)] select GVAR(SwapOrder);
private _hPos = PX(2.2);
private _wPos = PY(0.3);

{
    if (ctrlShown _x) then {

        private _lineIndex = _x getVariable QGVAR(lineIndex);
        private _color = _x getVariable QGVAR(color);
        private _alpha = (2.5 + ((_lineIndex - floor (_viewDirection / 5)) * 5) - (_viewDirection % 5)) call FUNC(getAlphaFromX);

        _x ctrlSetPosition [PX(_lineIndex * 2.5 + 0.15), _yPos, _hPos, _wPos];
        _x ctrlSetTextColor [_color select 0, _color select 1, _color select 2, (_color select 3) * _alpha];
        _x ctrlCommit 0;
    };
} forEach GVAR(lineMarkerControlPool);

// Icon marker
private _nextIconMarkerControl = 0;

private _yOffSet = [PY(0.75), PY(2.15)] select GVAR(SwapOrder);

{
    _x params ["_unit", "_color", "_icon", "_size", "_lastSeen"];

    // Check if the unit is not the player himself and alive.
    if (!isNull _unit) then {
        private _unitPosition = getPosVisual _unit;
        private _relativeVectorToUnit = _unitPosition vectorDiff _currentPosition;
        private _angleToUnit = ((_relativeVectorToUnit select 0) atan2 (_relativeVectorToUnit select 1) + 360) % 360;

        private _control = GVAR(iconMarkerControlPool) select _nextIconMarkerControl;
        if (isNil "_control" || {isNull _control}) then {
            _control = _dialog ctrlCreate ["RscPicture", 7501 + _nextIconMarkerControl, _holderControl];
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


        if (GVAR(showSpeaking)) then {
            _icon = [
                _icon,
                "\A3\ui_f\data\GUI\RscCommon\RscDebugConsole\feedback_ca.paa",
                "\A3\modules_f_curator\Data\portraitRadio_ca.paa"
            ] select (_unit getVariable [QEGVAR(radar,isSpeaking), 0])
        };

        _control ctrlSetText _icon;

        private _alpha = ((1 - 0.2 * ((_player distance _unit) - (diwako_dui_compassRange - 6))) min 1) * ((_compassAngle - _viewDirection) call FUNC(getAlphaFromX)) min 1;

        if (GVAR(enableOcclusion)) then {
            private _lastSeenAlphaMultiplier = (((GVAR(cocclusionFadeSpeed) - (time - _lastSeen)) / GVAR(cocclusionFadeSpeed)) min 1) max 0;
            _alpha = _alpha * _lastSeenAlphaMultiplier;
        };

        _color set [3, _alpha];
        _control ctrlSetTextColor _color;

        private _positionCenter = [PX(_compassAngle * 0.5) - ((_size select 0) / 2), _yOffSet - ((_size select 1) / 2)];
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
