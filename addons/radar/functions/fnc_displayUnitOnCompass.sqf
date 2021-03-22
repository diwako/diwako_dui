#include "script_component.hpp"
params [
    ["_grp", [], [[]]],
    "_display",
    ["_viewDir", 0],
    ["_playerDir", 0],
    "_player",
    "_ctrlGrp"
];

if (_grp isEqualTo []) exitWith {[]};
if (isNil "_player") then {
    _player = [] call CBA_fnc_currentUnit;
};
private _circleRange = diwako_dui_compassRange;
private _usedCtrls = [];
private _iconScale = diwako_dui_compass_icon_scale;
private _distanceWarning = diwako_dui_distanceWarning;
private _speakingArray = ["", EGVAR(main,speakingIcon), EGVAR(main,speakingRadioIcon)];

if (GVAR(vehicleCompassEnabled) && { _player call EFUNC(main,isInCrew) }) then {
    _circleRange = GVAR(compassRangeCrew);
    _iconScale = GVAR(icon_scale_crew);
    _distanceWarning = linearConversion [
        DUI_MIN_VEHICLE_RANGE, DUI_MAX_VEHICLE_RANGE, GVAR(compassRangeCrew),
        _distanceWarning, 100
    ];
};

{
    private _unit = _x;
    private _unitID = _unit getVariable ["diwako_dui_unit_id", nil];
    if (isNil "_unitID") then {
        _unitID = (missionNamespace getVariable ["diwako_dui_lastID", 0])+1;
        missionNamespace setVariable ["diwako_dui_lastID", _unitID];
        _unit setVariable ["diwako_dui_unit_id", _unitID];
    };

    private _distance = (getPosVisual _player) distance2d (getPosVisual _unit);
    private _alpha = 0;
    private _relDir = 0;
    if (_distance <= _circleRange) then {
        _alpha = linearConversion [_circleRange * 0.90, _circleRange, _distance, diwako_dui_compass_opacity, 0, true];
        private _rDir = ((((getPosVisual _player) getDir (getPosVisual _unit)) - _playerDir) + 360) % 360;
        _relDir = (_rDir - (_viewDir - _playerDir) ) mod 360;
    };

    private _ctrl = _ctrlGrp getVariable [format ["diwako_dui_ctrl_unit_%1", _unitID], controlNull];
    _alpha = _alpha min ([GVAR(icon_opacity), 1] select (_player isEqualTo _unit && {GVAR(icon_opacity_no_player)}));


    if (_alpha <= 0) then {
        ctrlDelete _ctrl;
    } else {
        private _dir = -(_viewDir - (getDirVisual _unit)) mod 360;
        private _divisor = linearConversion [35, 50, _circleRange, 2.25, 2.75, false] / diwako_dui_hudScaling; //2.25;

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

        ctrlPosition _ctrlGrp params ["", "", "_width", "_height"];
        private _dist = _distance / linearConversion [15, 50, _circleRange, 40, 145, false];
        private _baseIconScale = _iconScale * (_unit getVariable [QGVAR(icon_size), 1]);
        private _newWidth = (44 * pixelW) /_divisor * _baseIconScale;
        private _newHeight = (44 * pixelH) /_divisor * _baseIconScale;

        _ctrl ctrlSetPosition [
            _width/2 + _width * (sin _relDir * _dist) - _newWidth/2,
            _height/2 - _height * (cos _relDir * _dist) - _newHeight/2,
            _newWidth,
            _newHeight
        ];
        _ctrl ctrlSetAngle [_dir,0.5,0.5,false];
        _ctrl ctrlCommit 0;

        private _color = [0.85, 0.4, 0];
        if (_distance > _distanceWarning || {!(isNull objectParent _unit) || {_unit isEqualTo _player}}) then {
            _color = + (_unit getVariable [QEGVAR(main,compass_color), [1,1,1]]);
        };
        _color pushBack _alpha;
        _ctrl ctrlSetTextColor _color;
        _ctrl ctrlSetText ([
            _unit getVariable [QGVAR(compass_icon), DUI_RIFLEMAN],
            _speakingArray select (_unit getVariable [QGVAR(isSpeaking), 0])
        ] select (GVAR(showSpeaking) && {_unit getVariable [QGVAR(isSpeaking), 0] > 0}));

        if (diwako_dui_enable_occlusion) then {
            private _lastSeen = _unit getVariable QGVAR(lastSeen);
            private _occlusionAlpha = 0;
            private _occlude = !isNil "_lastSeen";
            if (_unit getVariable ["diwako_dui_lastChecked", -1] < time) then {
                private _delay = [1,0.2] select (missionNamespace getVariable [QEGVAR(indicators,show), true]);

                _unit setVariable ["diwako_dui_lastChecked", time + _delay];
                private _vis = [vehicle _unit, "VIEW"] checkVisibility [eyePos _player,  AGLToASL (_unit modelToWorldVisual (_unit selectionPosition "Spine2"))];
                private _cone = if (_relDir > 180) then { abs (_relDir - 360)} else { abs _relDir};
                if (_vis isEqualTo 0 || {GVAR(enable_occlusion_actual_cone) < _cone}) then {
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
                _occlusionAlpha = linearConversion [0, GVAR(occlusion_fade_time), time - _lastSeen, 1, 0, true] min _alpha;
                _ctrl ctrlSetFade (1 - _occlusionAlpha);
                _ctrl ctrlCommit 0;
            } else {
                _occlusionAlpha = 1;
                _ctrl ctrlSetFade 0;
                _ctrl ctrlCommit (GVAR(occlusion_fade_in_time) / 2);
            };
            _unit setVariable [QGVAR(occlusion_alpha), _occlusionAlpha];
        };

        _usedCtrls pushback _ctrl;
    };
} forEach _grp;

_usedCtrls
