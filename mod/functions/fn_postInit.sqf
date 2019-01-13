// start the loop
if (is3DEN) exitWith {};
[] call diwako_dui_fnc_cacheLoop;

private _label = localize "STR_dui_buddy_action";
private _range = 10;
if (isNil "ace_interact_menu_fnc_createAction") then {
	[[_label, {
		[player, cursorObject] call diwako_dui_fnc_pairBuddies;
	}, [], -5000, false, true, "", "cursorObject in (units group player)", _range]] call CBA_fnc_addPlayerAction;
} else {
	private _action = ["diwako_dui_buddy_action", _label, "", {
		[ace_player, _target] call diwako_dui_fnc_pairBuddies;
	},{_target in (units group ace_player)},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

	["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
};
