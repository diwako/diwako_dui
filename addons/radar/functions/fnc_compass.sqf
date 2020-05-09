#include "script_component.hpp"

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
GVAR(compass_pfHandle) = [GVAR(fnc_compassPFH), diwako_dui_compassRefreshrate, [_display, _compass, _dirCtrl, _ctrlGrp] ] call CBA_fnc_addPerFrameHandler;
