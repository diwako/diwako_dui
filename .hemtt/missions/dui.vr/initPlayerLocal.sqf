enableSaving [false,false];
if (!isMultiplayer) then {
	[["<t color='#ffff00'>[ Arsenal ]</t>", {["Open", true] spawn bis_fnc_arsenal}, 0, -85, false, true, "", ""]] call CBA_fnc_addPlayerAction;
	[player, true] spawn ace_arsenal_fnc_initBox;
	[["<t color='#ffff00'>[ ACE Arsenal ]</t>", {[player, player] call ace_arsenal_fnc_openBox}, 0, -85, false, true, "", ""]] call CBA_fnc_addPlayerAction;
	enableSaving [false, false];
	[["<t color='#ff0000'>[ Add tracers ]</t>", {[player, 20] spawn BIS_fnc_traceBullets;}, 0, -85, false, true, "", ""]] call CBA_fnc_addPlayerAction;
	[["<t color='#ff0000'>[ Remove tracers ]</t>", {[player, 0] spawn BIS_fnc_traceBullets;}, 0, -85, false, true, "", ""]] call CBA_fnc_addPlayerAction;
};

diwako_dui_special_track = [shall,shall2,shall3,farted];

diwako_dui_special_track pushBack hank;
hank setVariable ["diwako_dui_radar_customIcon", "yes.paa"];
hank setVariable ["diwako_dui_nametags_customGroup", "Custom group name"];

[] spawn {
	sleep 5;
	[shall2] joinsilent (group player);
	shall2 setVariable ["ACE_isEOD", 1, true];
	sleep 5;
	[shall2_1] joinsilent (group player);
	sleep 5;
	[shall2_2] joinsilent (group player);
};
