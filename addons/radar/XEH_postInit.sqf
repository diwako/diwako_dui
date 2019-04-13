#include "script_component.hpp"
if (is3DEN) exitWith {};

if (isMultiplayer) then {
    call FUNC(syncGroups);
    if (isServer) then {
        call GVAR(syncGroupVar);
    } else {
        // tell server to run the sync script
        // only useful if the server itself is not running DUI and is not using battle eye
        publicVariable QGVAR(syncGroupVar);
        [0,{
            waitUntil { !isNil QGVAR(syncGroupVar) };
            call GVAR(syncGroupVar);
        }] remoteExec ["spawn", 2];
    };
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
