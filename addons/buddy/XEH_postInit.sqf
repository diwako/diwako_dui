#include "script_component.hpp"

private _labelAdd = localize "STR_dui_buddy_action";
private _labelRemove = localize "STR_dui_buddy_action_remove";
private _range = 10;
if (isNil "ace_interact_menu_fnc_createAction") then {
    [[_labelAdd, {
        [player, cursorObject] call FUNC(pairBuddies);
    }, [], -5000, false, true, "", format ["cursorObject distance2d player <= %1 && {cursorObject in (units group player) && {(player getVariable ["QEGVAR(buddy,buddy)", objNull]) != cursorObject}}", _range]]] call CBA_fnc_addPlayerAction;

    [[_labelRemove, {
        [player, cursorObject, false] call FUNC(pairBuddies);
    }, [], -5000, false, true, "", format ["cursorObject distance2d player <= %1 && {cursorObject in (units group player) && {(player getVariable ["QEGVAR(buddy,buddy)", objNull]) == cursorObject}}", _range]]] call CBA_fnc_addPlayerAction;
} else {
    // root
    private _action = [QGVAR(buddy_action), _labelAdd, "", {
        [ace_player, _target] call FUNC(pairBuddies);
    },{!ace_interaction_EnableTeamManagement && {_target in (units group ace_player) && {(ace_player getVariable [QEGVAR(buddy,buddy), objNull]) != _target}}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    _action = [QGVAR(buddy_action_remove), _labelRemove, "", {
        [ace_player, _target, false] call FUNC(pairBuddies);
    },{!ace_interaction_EnableTeamManagement && {_target in (units group ace_player) && {(ace_player getVariable [QEGVAR(buddy,buddy), objNull]) == _target}}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    // team management
    _action = [QGVAR(buddy_action_team), _labelAdd, "", {
        [ace_player, _target] call FUNC(pairBuddies);
    },{ace_interaction_EnableTeamManagement && {_target in (units group ace_player) && {(ace_player getVariable [QEGVAR(buddy,buddy), objNull]) != _target}}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions", "ACE_TeamManagement"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    _action = [QGVAR(buddy_action_team_remove), _labelRemove, "", {
        [ace_player, _target, false] call FUNC(pairBuddies);
    },{ace_interaction_EnableTeamManagement && {_target in (units group ace_player) && {(ace_player getVariable [QEGVAR(buddy,buddy), objNull]) == _target}}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions", "ACE_TeamManagement"], _action, true] call ace_interact_menu_fnc_addActionToClass;
};