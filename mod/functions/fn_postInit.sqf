// start the loop
if (is3DEN) exitWith {};
[] call diwako_dui_fnc_cacheLoop;

private _label = "HUD: Set As Squad Buddy";
if (isNil "ace_interact_menu_fnc_createAction") then {
	[[_label, {
		[player, cursorObject] call diwako_dui_fnc_pairBuddies;
	}, [], -5000, false, true, "", "cursorObject in (units group player)", 3]] call CBA_fnc_addPlayerAction;
} else {
	private _action = ["diwako_dui_buddy_action", _label, "", {
		[ace_player, _target] call diwako_dui_fnc_pairBuddies;
	},{cursorObject in (units group ace_player)},{},[], [0,0,0], 3] call ace_interact_menu_fnc_createAction;

	["CAManBase", 0, ["ACE_MainActions","ACE_TeamManagement"], _action, true] call ace_interact_menu_fnc_addActionToClass;
};
