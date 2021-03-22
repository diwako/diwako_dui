#include "script_component.hpp"

params ["", "_fingerPosPrecise"];
private _player = call CBA_fnc_currentUnit;
if !(GVAR(ace_finger) &&                            // ace finger enabled
    {[_player] call EFUNC(main,canHudBeShown) &&    // hud can be shown
    {diwako_dui_enable_compass &&                   // compass is enabled
    {                                               // hide compass when alone enabled and alone in group
        (!diwako_dui_compass_hide_alone_group) || {(units group _player) isNotEqualTo [_player] && {diwako_dui_compass_hide_alone_group}}
    }}}) exitWith {};
private _texture = GVAR(pointerPaths) getVariable GVAR(pointer_style);
if (isNil "_texture") exitWith {
    [["DUI ACE Pointing", 2], ["No texture return for pointer style"], [GVAR(pointer_style)]] call CBA_fnc_notify;
};

private _display = uiNamespace getVariable ["diwako_dui_RscCompass", displayNull];
if (isNull _display) exitWith {};

private _ctrlHeight = pixelH * GVAR(uiPixels);
private _ctrlWidth = pixelW * GVAR(uiPixels);
private _ctrlMiddleX = 0.5 - (pixelW * (GVAR(uiPixels) / 2));
private _compassY = safeZoneY + safeZoneH - (pixelH * (GVAR(uiPixels) + 10));

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
