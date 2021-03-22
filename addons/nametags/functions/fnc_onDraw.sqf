#include "script_component.hpp"

if (isGamePaused || !isGameFocused) exitWith {};
(_this select 0) params ["_ctrl"];
if (isNull _ctrl) exitWith {};
private _pos = [GET_POS_X, GET_POS_Y, GET_POS_W, GET_POS_H];
if !((ctrlPosition _ctrl) isEqualTo _pos) then {
    _ctrl ctrlSetPosition _pos;
};

private _target = cursorObject;
private _player = call CBA_fnc_currentUnit;

if (GVAR(useLIS) && {!(isNull (objectParent _player)) || {(crew _target) isNotEqualTo []}}) then {
    private _lis = lineIntersectsSurfaces [
        AGLToASL positionCameraToWorld [0, 0, 0],
        AGLToASL positionCameraToWorld [0, 0, GVAR(renderDistance) + 1],
        objNull,
        objNull,
        true,
        -1,
        "FIRE"
    ];
    {
        _x params ["", "", "_obj"];
        if (_obj isKindOf "CAManBase" && _obj != _player) then {
            _target = _obj;
            break;
        };
    } forEach _lis;
};

if (isNull _target || !(player call EFUNC(main,canHudBeShown))) then {
    GVAR(targetedFade) = 1;
} else {

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
    if (_target isKindOf "AllVehicles" && {_areFriendly} && {!unitIsUAV _target}) then {
        GVAR(targetedFade) = [_target, _player] call FUNC(calculateFadeValue);
        if (GVAR(targetedFade) < 1) then {
            private _color = EGVAR(main,colors_custom) getVariable ["otherName", "#33FF00"]; // Other Group Default Color
            private _colorGroup = EGVAR(main,colors_custom) getVariable ["otherGroup", "#99D999"]; // Other Group Default Color
            if ((group _target) isEqualTo (group _player)) then {
                _color = _target getVariable [QEGVAR(main,color), "#FFFFFF"];
                _colorGroup = EGVAR(main,colors_custom) getVariable ["group", "#FFFFFF"];
            };
            private _alive = alive _target;
            if (GVAR(showUnconAsDead) && _alive) then {
                _alive = (lifeState _target) != "INCAPACITATED";
            };
            if !(_alive) then {
                _color = EGVAR(main,colors_custom) getVariable ["dead", "#333333"];
                _colorGroup = EGVAR(main,colors_custom) getVariable ["otherGroup", "#99D999"];; // Other Group Default Color
            };
            private _tags = "<t font='%1' color='%2' size='%3' shadow='%4'>";
            private _data = ["<t align='center' valign='middle'>"];
            _data pushBack format [_tags, GVAR(fontName), _color, (GET_POS_H) * GVAR(fontNameSize), GVAR(nameFontShadow)];

            if (GVAR(drawRank)) then {
                _data pushBack format ["%1. ", _target getVariable [QGVAR(rank), rank _target]];
            };

            _data pushBack (_target getVariable ["ACE_Name", _target getVariable [QGVAR(name), name _target]]);

            _data append ["</t>", "<br/>"];
            _data pushBack format [_tags, GVAR(fontGroup), _colorGroup, (GET_POS_H) * GVAR(fontGroupNameSize), GVAR(groupFontShadow)];

            _data pushBack (_target getVariable [QGVAR(groupName), groupID (group _target)]);
            _data append ["</t>", "</t>"];
            // TODO(joko): Add Extra Fade for Group?
            _ctrl ctrlSetStructuredText parseText (_data joinString "");
        };
    } else {
        GVAR(targetedFade) = 1;
    };
};

GVAR(targetedFade) = (GVAR(targetedFade) min 1) max 0;

private _fadeIn = GVAR(targetedFade) <= ctrlFade _ctrl;
_ctrl ctrlSetFade GVAR(targetedFade);
if (_fadeIn) then {
    _ctrl ctrlCommit GVAR(fadeInTime);
} else {
    _ctrl ctrlCommit GVAR(fadeOutTime);
};
