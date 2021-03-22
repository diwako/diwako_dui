#include "script_component.hpp"


params ["_args", "_pfhHandle"];
_args params ["_display", "_compassCtrl", "_dirCtrl", "_ctrlGrp"];

if (!isGameFocused || isGamePaused) exitWith {};

if !(diwako_dui_enable_compass) exitWith {
    [_pfhHandle] call CBA_fnc_removePerFrameHandler;
    "diwako_dui_compass" cutText ["","PLAIN"];
    GVAR(compass_pfHandle) = -1;
};

private _player = [] call CBA_fnc_currentUnit;
private _grp = GVAR(group);
private _pointers = GVAR(pointers);

if (diwako_dui_compass_hide_alone_group && {count (units group _player) <= 1}) exitWith {
    _compassCtrl ctrlShow false;
    _dirCtrl ctrlShow false;
    _ctrlGrp ctrlShow false;
};

if ([_player] call EFUNC(main,canHudBeShown)) then {
    if !(ctrlShown _ctrlGrp) then {
        _ctrlGrp ctrlShow true;
        _compassCtrl ctrlShow true;
        _dirCtrl ctrlShow true;
    };
    private _camDirVec = positionCameratoWorld [0,0,0] vectorFromTo (positionCameraToWorld [0,0,1]);
    private _dir = _camDirVec call CBA_fnc_vectDir;
    // private _dir = (getCameraViewDirection _player) call CBA_fnc_vectDir;
    private _hasCompass = ([_player] call FUNC(getCompass)) isNotEqualTo "";

    _compassCtrl ctrlSetAngle [[0,-_dir] select _hasCompass, 0.5, 0.5, true];

    if (_hasCompass && {diwako_dui_enable_compass_dir isEqualTo 2 || {diwako_dui_enable_compass_dir isEqualTo 1 && {!(isNull objectParent _player)}}}) then {
        private _dirCalc = (round _dir) mod 360;
        private _maxDegrees = GVAR(maxDegrees);
        if (_maxDegrees isNotEqualTo 360) then {
            _dirCalc = (round (linearConversion [0, 360, _dir, 0, _maxDegrees, true])) mod _maxDegrees;
        };
        if (_maxDegrees isNotEqualTo 6400 && {diwako_dui_dir_showMildot}) then {
            _dirCtrl ctrlSetStructuredText parseText format ["<t align='center' size='%3' shadow='2' shadowColor='#000000'>%1 | %2</t>", [_dirCalc, [1,3] select GVAR(leadingZeroes)] call CBA_fnc_formatNumber, [round (_dir / 0.056250), [1,4] select GVAR(leadingZeroes)] call CBA_fnc_formatNumber, GVAR(bearing_size_calc)];
        } else {
            _dirCtrl ctrlSetStructuredText parseText format ["<t align='center' size='%2' shadow='2' shadowColor='#000000'>%1</t>", [_dirCalc, [1,3] select GVAR(leadingZeroes)] call CBA_fnc_formatNumber, GVAR(bearing_size_calc)];
        };
    } else {
        _dirCtrl ctrlSetText "";
    };

    private _ctrls = _ctrlGrp getVariable ["diwako_dui_ctrlArr",[]];
    private _playerDir = getDirVisual _player;

    private _usedCtrls = [_grp, _display, _dir, _playerDir, _player, _ctrlGrp] call FUNC(displayUnitOnCompass);

    {
        ctrlDelete _x;
    } forEach (_ctrls - _usedCtrls);

    if (diwako_dui_compass_hide_blip_alone_group && { _grp isEqualTo (missionNamespace getVariable ["diwako_dui_special_track", []]) && {(count _usedCtrls) > 0}}) then {
        _usedCtrls pushBack (([[_player], _display, _dir, _playerDir, _player, _ctrlGrp] call FUNC(displayUnitOnCompass)) select 0);
    };
    _ctrlGrp setVariable ["diwako_dui_ctrlArr", _usedCtrls];

    if (_pointers isNotEqualTo []) then {
        for "_i" from (count _pointers) -1 to 0 step -1 do {
            (_pointers select _i) params [["_pointer", controlNull], "_pointerPos"];
            if (isNull _pointer) then {
                _pointers deleteAt _i;
            } else {
                _pointer ctrlSetAngle [(((_player getRelDir (_pointerPos)) - (_dir - _playerDir) ) mod 360), 0.5, 0.5, false];
                _pointer ctrlCommit 0;
            };
        };
    };

    if !(isNil "diwako_dui_custom_code") then {
        /*
            Keep in mind this runs EVERY FRAME!
            1. Display of the RscTile
            2. Control of the compass
            3. Control of the bearing indicator
            4. Control group of the units displayed on the compass
            5. All currently shown unit icons on the compass
        */
        [_display, _compassCtrl, _dirCtrl, _ctrlGrp, _usedCtrls] call diwako_dui_custom_code;
    };
} else {
    _compassCtrl ctrlShow false;
    _dirCtrl ctrlShow false;
    _ctrlGrp ctrlShow false;
};
