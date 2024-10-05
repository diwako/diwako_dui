#include "script_component.hpp"
if (is3DEN) exitWith {};

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

if (isClass(configFile >> "CfgPatches" >> "ace_finger")) then {
    ["ace_finger_fingered", {
        _this call FUNC(incomingFinger);
    }]  call CBA_fnc_addEventHandler;
};

if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    [QGVAR(OnSpeak), "OnSpeak", {
        params ["_unit", "_isSpeaking"];
        if !(_isSpeaking) exitWith {
            _unit setVariable [QGVAR(isSpeaking), nil];
        };
        if (GVAR(showSpeaking_radioOnly)) exitWith {};
        _unit setVariable [QGVAR(isSpeaking), 1];
    }, objNull] call TFAR_fnc_addEventHandler;

    [[], {
        if !(hasInterface && {isNil QGVAR(onTangent)}) exitWith {};
        private _eventId = [QGVAR(onTangent), "onTangent", {
            ["TFAR_event_onTangentRemote", _this, units (_this select 0)] call CBA_fnc_targetEvent;
        }, objNull] call TFAR_fnc_addEventHandler;
        if (isNil "_eventId") then {
            _eventId = QGVAR(onTangent);
        };
        GVAR(onTangent) = _eventId;
    }] remoteExecCall ["call", 0, true];
};
