#include "script_component.hpp"
if (is3DEN) exitWith {};

if (isMultiplayer && {GVAR(sortType) == "none"}) then {
    call FUNC(syncGroups);
};

if !(hasInterface) exitWith {};

GVAR(uiPixels) = DUI_128PX;

GVAR(a3UiScale) = linearConversion [0.55,0.7,getResolution select 5,1,0.85,false];
GVAR(windowHeightMod) = linearConversion [1080,1440,getResolution select 1,1,0.75,false];
GVAR(bearing_size_calc) = diwako_dui_dir_size * GVAR(a3UiScale) * diwako_dui_hudScaling * GVAR(windowHeightMod);
GVAR(vehicleNamespace) = [] call CBA_fnc_createNamespace;

if !(isNil "ace_nightvision") then {
   "ace_nightvision_display" cutFadeOut 0;
};

if !(isNil "ace_goggles") then {
    "ace_goggles_GogglesEffectsLayer" cutFadeOut 0;
    "ace_goggles_GogglesLayer" cutFadeOut 0;
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
        _this call FUNC(incomingFinger);
    }]  call CBA_fnc_addEventHandler;
};

private _tfar = isClass (configFile >> "CfgPatches" >> "tfar_core");
private _tfarOld = isClass (configFile >> "CfgPatches" >> "task_force_radio");
if (_tfar || _tfarOld) then {
    [[], {
        if !(hasInterface && {isNil QGVAR(onTangent)}) exitWith {};
        GVAR(onTangent) = ["TFAR_event_onTangent", {
            ["TFAR_event_onTangentRemote", _this, units (_this select 0)] call CBA_fnc_targetEvent;
        }] call CBA_fnc_addEventHandler;
    }] remoteExecCall ["call", 0, true];
};
