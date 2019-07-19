#include "script_component.hpp"
if (is3DEN) exitWith {};

if (isMultiplayer && {GVAR(sortType) == "none"}) then {
    call FUNC(syncGroups);
};

if !(hasInterface) exitWith {};

GVAR(uiPixels) = DUI_128PX;

GVAR(a3UiScale) = linearConversion [0.55,0.7,getResolution # 5,1,0.85,false];
GVAR(windowHeightMod) = linearConversion [1080,1440,getResolution # 1,1,0.75,false];
GVAR(bearing_size_calc) = diwako_dui_dir_size * GVAR(a3UiScale) * diwako_dui_hudScaling * GVAR(windowHeightMod);
GVAR(vehicleNamespace) = [] call CBA_fnc_createNamespace;

if !(isNil "ace_nightvision") then {
   "ace_nightvision_display" cutFadeOut 0;
};

"diwako_dui_compass" cutFadeOut 0;
"diwako_dui_namebox" cutFadeOut 0;

// start the loop
[] call FUNC(cacheLoop);

[QEGVAR(main,hudToggled), {
    params ["_toggledOff"];
    if (_toggledOff) then {
        // set position and size for namelist and compass
        [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
    };
}] call CBA_fnc_addEventHandler;

[QEGVAR(main,refreshUI), {
    [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(refreshUI), {
    GVAR(setCompass) = true;
    GVAR(setNamelist) = true;
    for "_i" from 0 to (count GVAR(namebox_lists)) do {
        ctrlDelete ctrlParentControlsGroup (GVAR(namebox_lists) deleteAt 0);
    };
}] call CBA_fnc_addEventHandler;

if (isClass(configfile >> "CfgPatches" >> "ace_finger")) then {
    ["ace_finger_fingered", {
        params ["_sourceUnit", "_fingerPosPrecise", "_distance"];
        if !(GVAR(ace_finger)) exitWith {};
        if !([call CBA_fnc_currentUnit] call EFUNC(main,canHudBeShown)) exitWith {};
        private _texture = GVAR(pointerPaths) getVariable GVAR(pointer_style);
        if (isNil "_texture") exitWith {
            [["DUI ACE Pointing", 2], ["No texture return for pointer style"], [GVAR(pointer_style)]] call CBA_fnc_notify;
        };

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

        private _display = findDisplay 46;
	    if (isNull _display) exitWith {};
        private _pointer = _display ctrlCreate ["RscPicture", -1];
        _pointer ctrlSetPosition [
            _ctrlMiddleX,
            _compassY,
            _ctrlWidth,
            _ctrlHeight
        ];
        _pointer ctrlSetTextColor [1 ,1 , 1, 1];
        _pointer ctrlSetText _texture;
        _pointer ctrlCommit 0;
        
        private _setting = [_pointer, _fingerPosPrecise];
        GVAR(pointers) pushBack _setting;

        [{
            // GVAR(pointers) = GVAR(pointers) - _this;
            ctrlDelete (_this select 0);
        }, _setting, 5] call CBA_fnc_waitAndExecute;
    }]  call CBA_fnc_addEventHandler;
};