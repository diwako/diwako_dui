#include "script_component.hpp"
if (is3DEN || !hasInterface) exitWith {};

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

private _labelAdd = localize "STR_dui_buddy_action";
private _labelRemove = localize "STR_dui_buddy_action_remove";
private _range = 10;
if (isNil "ace_interact_menu_fnc_createAction") then {
    [[_labelAdd, {
        [player, cursorObject] call FUNC(pairBuddies);
    }, [], -5000, false, true, "", format ["cursorObject distance2d player <= %1 && {cursorObject in (units group player) && {(player getVariable ["QGVAR(buddy)", objNull]) != cursorObject}}", _range]]] call CBA_fnc_addPlayerAction;

    [[_labelRemove, {
        [player, cursorObject, false] call FUNC(pairBuddies);
    }, [], -5000, false, true, "", format ["cursorObject distance2d player <= %1 && {cursorObject in (units group player) && {(player getVariable ["QGVAR(buddy)", objNull]) == cursorObject}}", _range]]] call CBA_fnc_addPlayerAction;
} else {
    private _action = [QGVAR(buddy_action), _labelAdd, "", {
        [ace_player, _target] call FUNC(pairBuddies);
    },{_target in (units group ace_player) && {(ace_player getVariable [QGVAR(buddy), objNull]) != _target}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    private _action = [QGVAR(buddy_action_remove), _labelRemove, "", {
        [ace_player, _target, false] call FUNC(pairBuddies);
    },{_target in (units group ace_player) && {(ace_player getVariable [QGVAR(buddy), objNull]) == _target}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

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
