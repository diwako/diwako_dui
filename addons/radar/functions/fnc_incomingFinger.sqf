#include "script_component.hpp"

params ["_sourceUnit", "_fingerPosPrecise", "_distance"];
if !(GVAR(ace_finger) && {[call CBA_fnc_currentUnit] call EFUNC(main,canHudBeShown) && {diwako_dui_enable_compass}}) exitWith {};
private _texture = GVAR(pointerPaths) getVariable GVAR(pointer_style);
if (isNil "_texture") exitWith {
    [["DUI ACE Pointing", 2], ["No texture return for pointer style"], [GVAR(pointer_style)]] call CBA_fnc_notify;
};

private _display = findDisplay 46;
if (isNull _display) exitWith {};

private _ctrlHeight = pixelH * GVAR(uiPixels);
private _ctrlWidth = pixelW * GVAR(uiPixels);
private _ctrlMiddleX = 0.5 - (pixelW * (GVAR(uiPixels) / 2));
private _compassY = safeZoneY + safeZoneH - (pixelH * (GVAR(uiPixels) + 10));

private _dirCtrl = _compassDisplay displayCtrl IDC_DIRECTION;
private _grpCtrl = _compassDisplay displayCtrl IDC_COMPASS_CTRLGRP;

if (diwako_dui_use_layout_editor) then {
    _ctrlMiddleX = profileNamespace getVariable ["igui_diwako_dui_compass_x", _ctrlMiddleX];
    _compassY = profileNamespace getVariable ["igui_diwako_dui_compass_y", _compassY];
    _ctrlWidth = profileNamespace getVariable ["igui_diwako_dui_compass_w", _ctrlWidth];
    _ctrlHeight = profileNamespace getVariable ["igui_diwako_dui_compass_h", _ctrlHeight];
};

private _pointer = _display ctrlCreate ["RscPicture", -1];
_pointer ctrlSetPosition [
    _ctrlMiddleX,
    _compassY,
    _ctrlWidth,
    _ctrlHeight
];
_pointer ctrlSetTextColor GVAR(pointer_color);
_pointer ctrlSetText _texture;
_pointer ctrlCommit 0;

private _setting = [_pointer, _fingerPosPrecise];
GVAR(pointers) pushBack _setting;

[{
    ctrlDelete _this;
}, _pointer, 2] call CBA_fnc_waitAndExecute;
