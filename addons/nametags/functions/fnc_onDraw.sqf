#include "script_component.hpp"

if (isGamePaused || !isGameFocused) exitWith {};
(_this select 0) params ["_ctrl"];
if (isNull _ctrl) exitWith {};
private _pos = [GET_POS_X, GET_POS_Y, GET_POS_W, GET_POS_H];
if ((ctrlPosition _ctrl) isNotEqualTo _pos) then {
    _ctrl ctrlSetPosition _pos;
};

private _target = cursorObject;
private _player = call CBA_fnc_currentUnit;
private _targetedFade = 1;

if (GVAR(useLIS)) then {
    private _skipVicCheck = (netId _target) isEqualTo "1:0"; // only ever true when cursorObject returns the weapon of a
    // unit, per the comment from Pierre MGI at https://community.bistudio.com/wiki/cursorObject
    // we'd like to find the cursorObject regardless, so we piggyback on the LIS check to find the most probable one

    // This is the best we can do without a positionCameraToWorldVisual command.
    // positionCameraToWorld translates position from camera space to world space in SIMULATION time scope,
    // while a theoretical positionCameraToWorldVisual command would translate positions from camera space to world
    // space in RENDER time scope.
    private _camPos = _player modelToWorldVisualWorld (_player selectionPosition "pilot");
    private _lis = lineIntersectsSurfaces [
        _camPos,
        _camPos vectorAdd ((getCameraViewDirection _player) vectorMultiply (GVAR(renderDistance) + 1)),
        _player,
        objNull,
        true,
        -1,
        "FIRE"
    ];
    {
        _x params ["", "", "_obj"];
        if (_obj isKindOf "CAManBase" &&
           {_obj isNotEqualTo _player &&
           {!isNull (objectParent _obj) || _skipVicCheck
        }}) then {
            _target = _obj;
            break;
        };
    } forEach _lis;
};

if !(isNull _target || {!(player call EFUNC(main,canHudBeShown)) || {unitIsUAV _target}}) then {
    private _effectiveCommander = effectiveCommander _target;
    if !(isNull _effectiveCommander) then {
        _target = _effectiveCommander;
    };

    private _targetSide = _target getVariable [QGVAR(side), side group _target];
    private _playerSide = _player getVariable [QGVAR(side), side group _player];
    private _areFriendly = if (GVAR(useSideIsFriendly)) then {
        [_playerSide, _targetSide] call BIS_fnc_sideIsFriendly;
    } else {
        _targetSide isEqualTo _playerSide;
    };
    if (_areFriendly && {_target isKindOf "AllVehicles"}) then {
        _targetedFade = (([_target, _player] call FUNC(calculateFadeValue)) min 1) max 0;
        if (_targetedFade < 1) then {
            private _color = EGVAR(main,colors_custom) getVariable ["otherName", "#33FF00"]; // Other Group Default Color
            private _colorGroup = EGVAR(main,colors_custom) getVariable ["otherGroup", "#99D999"]; // Other Group Default Color
            if ((group _target) isEqualTo (group _player)) then {
                _color = _target getVariable [QEGVAR(main,color), "#FFFFFF"];
                _colorGroup = EGVAR(main,colors_custom) getVariable ["group", "#FFFFFF"];
            };
            private _alive = alive _target;
            if (GVAR(showUnconAsDead) && _alive) then {
                _alive = (lifeState _target) isNotEqualTo "INCAPACITATED";
            };
            if !(_alive) then {
                _color = EGVAR(main,colors_custom) getVariable ["dead", "#333333"];
                _colorGroup = EGVAR(main,colors_custom) getVariable ["otherGroup", "#99D999"];; // Other Group Default Color
            };
            private _tags = "<t font='%1' color='%2' size='%3' shadow='%4'>";
            private _data = ["<t align='center' valign='middle'>"];
            _data pushBack format [_tags, GVAR(fontName), _color, (GET_POS_H) * GVAR(fontNameSize), GVAR(nameFontShadow)];

            if (GVAR(drawRank)) then {
                _data pushBack format ["%1 ", _target getVariable [QGVAR(rank), rank _target]];
            };

            _data pushBack (_target getVariable [QGVAR(name), name _target]);

            _data append ["</t>", "<br/>"];
            _data pushBack format [_tags, GVAR(fontGroup), _colorGroup, (GET_POS_H) * GVAR(fontGroupNameSize), GVAR(groupFontShadow)];

            _data pushBack (_target getVariable [QGVAR(groupName), groupId (group _target)]);
            _data append ["</t>", "</t>"];
            // TODO(joko): Add Extra Fade for Group?
            _ctrl ctrlSetStructuredText parseText (_data joinString "");
        };
    };
};

_ctrl ctrlSetFade _targetedFade;
_ctrl ctrlCommit ([GVAR(fadeOutTime), GVAR(fadeInTime)] select (_targetedFade <= ctrlFade _ctrl));
