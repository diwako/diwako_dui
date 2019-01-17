#include "../script_component.hpp"
// start the loop
if (is3DEN || !hasInterface) exitWith {};

diwako_dui_uiPixels = DUI_128PX;

[] call diwako_dui_fnc_cacheLoop;

private _label = localize "STR_dui_buddy_action";
private _range = 10;
if (isNil "ace_interact_menu_fnc_createAction") then {
	[[_label, {
		[player, cursorObject] call diwako_dui_fnc_pairBuddies;
	}, [], -5000, false, true, "", format ["cursorObject distance2d player <= %1 && {cursorObject in (units group player) && {(player getVariable [""diwako_dui_buddy"", objNull]) != cursorObject}}", _range]]] call CBA_fnc_addPlayerAction;
} else {
	private _action = ["diwako_dui_buddy_action", _label, "", {
		[ace_player, _target] call diwako_dui_fnc_pairBuddies;
	},{_target in (units group ace_player) && {(ace_player getVariable ["diwako_dui_buddy", objNull]) != _target}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

	["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
};


private _label = localize "STR_dui_buddy_action_remove";

if (isNil "ace_interact_menu_fnc_createAction") then {
	[[_label, {
		[player, cursorObject, false] call diwako_dui_fnc_pairBuddies;
	}, [], -5000, false, true, "", format ["cursorObject distance2d player <= %1 && {cursorObject in (units group player) && {(player getVariable [""diwako_dui_buddy"", objNull]) == cursorObject}}", _range]]] call CBA_fnc_addPlayerAction;
} else {
	private _action = ["diwako_dui_buddy_action", _label, "", {
		[ace_player, _target, false] call diwako_dui_fnc_pairBuddies;
	},{_target in (units group ace_player) && {(ace_player getVariable ["diwako_dui_buddy", objNull]) == _target}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

	["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

// cba eh for hiding the hud when in certain camera modes
["featureCamera", {
    params ["_player", "_featureCamera"];
    diwako_dui_inFeatureCamera = !(_featureCamera isEqualTo "");
}, true] call CBA_fnc_addPlayerEventHandler;