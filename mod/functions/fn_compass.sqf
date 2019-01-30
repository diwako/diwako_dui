#include "../script_component.hpp"
if (is3DEN || !hasInterface) exitWith {};
params [["_display", displayNull]];
if !(diwako_dui_enable_compass) exitWith {};

if (isNull _display) then {
    _display = uiNamespace getVariable "diwako_dui_RscCompass";
};

if (isNull _display) exitWith {systemChat "No Display"};

private _ctrlGrp = _display displayCtrl IDC_COMPASS_CTRLGRP;
private _compass = _display displayCtrl IDC_COMPASS;
private _dirCtrl = _display displayCtrl IDC_DIRECTION;
diwako_dui_compass_pfHandle = [{
    params ["_args", "_pfhHandle"];
    _args params ["_display", "_compassCtrl", "_dirCtrl", "_ctrlGrp"];

    if !(diwako_dui_enable_compass) exitWith {
        [_pfhHandle] call CBA_fnc_removePerFrameHandler;
        ("diwako_dui_compass" call BIS_fnc_rscLayer) cutText ["","PLAIN"];
        diwako_dui_compass_pfHandle = -1;
    };

    private _player = [] call CBA_fnc_currentUnit;
    if ([_player] call diwako_dui_fnc_canHudBeShown) then {
        if !(ctrlShown _ctrlGrp) then {
            _ctrlGrp ctrlShow true;
            _compassCtrl ctrlShow true;
            _dirCtrl ctrlShow true;
        };
        private _camDirVec = positionCameratoWorld [0,0,0] vectorFromTo (positionCameraToWorld [0,0,1]);
        private _dir = _camDirVec call CBA_fnc_vectDir;
        // private _dir = (getCameraViewDirection _player) call CBA_fnc_vectDir;
        private _hasCompass = ("ItemCompass" in assignedItems _player);

        _compassCtrl ctrlSetAngle [[0,-_dir] select _hasCompass, 0.5, 0.5, true];

        if (_hasCompass && {diwako_dui_enable_compass_dir == 2 || {diwako_dui_enable_compass_dir == 1 && {!(isNull objectParent _player)}}}) then {
            if (diwako_dui_dir_showMildot) then {
                _dirCtrl ctrlSetStructuredText parseText format ["<t align='center' size='%3' shadow='2' shadowColor='#000000'>%1 | %2</t>", (round _dir) mod 360, round (_dir / 0.056250), 1.25 * diwako_dui_a3UiScale * diwako_dui_hudScaling];
            } else {
                _dirCtrl ctrlSetStructuredText parseText format ["<t align='center' size='%2' shadow='2' shadowColor='#000000'>%1</t>", (round _dir) mod 360, 1.25 * diwako_dui_a3UiScale * diwako_dui_hudScaling];
            };
        } else {
            _dirCtrl ctrlSetText "";
        };


        private _usedCtrls = [];
        private _ctrls = _ctrlGrp getVariable ["diwako_dui_ctrlArr",[]];
        private _playerDir = getDir _player;

        {
            _usedCtrls pushBack ([_x, _display, _dir, _playerDir, _player, _ctrlGrp] call diwako_dui_fnc_displayUnitOnCompass);
        } forEach diwako_dui_group;

        private _unusedCtrls = _ctrls - _usedCtrls;
        {
            ctrlDelete _x;
        } forEach _unusedCtrls;

        (_display displayCtrl IDC_COMPASS_CTRLGRP) setVariable ["diwako_dui_ctrlArr",_usedCtrls];

        if !(isNil "diwako_dui_custom_code") then {
            /*
                Keep in mind this runs EVERY FRAME!
                1. Display of the RscTile
                2. Control of the compass
                3. Control of the bearing indicator
                4. Control group of the units displayed on the compass
                5. All currently shown unit icons on the compass
            */
            [_display, _compass, _dirCtrl, _ctrlGrp, _usedCtrls] call diwako_dui_custom_code;
        };
    } else {
        _compassCtrl ctrlShow false;
        _dirCtrl ctrlShow false;
        _ctrlGrp ctrlShow false;
    };
}, diwako_dui_compassRefreshrate, [_display, _compass, _dirCtrl, _ctrlGrp] ] call CBA_fnc_addPerFrameHandler;
