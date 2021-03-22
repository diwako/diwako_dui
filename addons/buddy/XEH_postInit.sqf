#include "script_component.hpp"

if !(hasInterface) exitWith {};

private _labelAdd = localize "STR_dui_buddy_action";
private _labelRemove = localize "STR_dui_buddy_action_remove";
private _range = 10;
if (isNil "ace_interact_menu_fnc_createAction") then {
    [[_labelAdd, {
        [player, cursorObject] call FUNC(pairBuddies);
    }, [], -5000, false, true, "", format ["cursorObject distance2d player <= %1 && {cursorObject in (units group player) && {(player getVariable ['%2', objNull]) isNotEqualTo cursorObject}}", _range, QGVAR(buddy)]]] call CBA_fnc_addPlayerAction;

    [[_labelRemove, {
        [player, cursorObject, false] call FUNC(pairBuddies);
    }, [], -5000, false, true, "", format ["cursorObject distance2d player <= %1 && {cursorObject in (units group player) && {(player getVariable ['%2', objNull]) isEqualTo cursorObject}}", _range, QGVAR(buddy)]]] call CBA_fnc_addPlayerAction;
} else {
    // root
    private _action = [QGVAR(buddy_action), _labelAdd, "", {
        params ["_target", "_player"];
        [_player, _target] call FUNC(pairBuddies);
    },{params ["_target", "_player"]; !(ace_interaction_EnableTeamManagement && [_player, _target] call ace_interaction_fnc_canJoinTeam) && {_target in (units group _player) && {(_player getVariable [QGVAR(buddy), objNull]) isNotEqualTo _target}}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    _action = [QGVAR(buddy_action_remove), _labelRemove, "", {
        params ["_target", "_player"];
        [_player, _target, false] call FUNC(pairBuddies);
    },{params ["_target", "_player"]; !(ace_interaction_EnableTeamManagement && [_player, _target] call ace_interaction_fnc_canJoinTeam) && {_target in (units group _player) && {(_player getVariable [QGVAR(buddy), objNull]) isEqualTo _target}}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    _action = [QGVAR(buddy_action_team_remove), _labelRemove, "", {
        params ["", "_player"];
        [_player, _player getVariable [QGVAR(buddy), objNull], false] call FUNC(pairBuddies);
    },{params ["", "_player"]; !ace_interaction_EnableTeamManagement && {!isNull (_player getVariable [QGVAR(buddy), objNull])}},{},[], [0,0,0]] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions", "ACE_TeamManagement"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    // team management
    _action = [QGVAR(buddy_action_team), _labelAdd, "", {
        params ["_target", "_player"];
        [_player, _target] call FUNC(pairBuddies);
    },{params ["_target", "_player"]; (ace_interaction_EnableTeamManagement && [_player, _target] call ace_interaction_fnc_canJoinTeam) && {(_player getVariable [QGVAR(buddy), objNull]) isNotEqualTo _target}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions", "ACE_TeamManagement"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    _action = [QGVAR(buddy_action_team_remove), _labelRemove, "", {
        params ["_target", "_player"];
        [_player, _target, false] call FUNC(pairBuddies);
    },{params ["_target", "_player"]; (ace_interaction_EnableTeamManagement && [_player, _target] call ace_interaction_fnc_canJoinTeam) && {(_player getVariable [QGVAR(buddy), objNull]) isEqualTo _target}},{},[], [0,0,0], _range] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 0, ["ACE_MainActions", "ACE_TeamManagement"], _action, true] call ace_interact_menu_fnc_addActionToClass;

    _action = [QGVAR(buddy_action_team_remove), _labelRemove, "", {
        params ["", "_player"];
        [_player, _player getVariable [QGVAR(buddy), objNull], false] call FUNC(pairBuddies);
    },{params ["", "_player"]; ace_interaction_EnableTeamManagement && {!isNull (_player getVariable [QGVAR(buddy), objNull])}},{},[], [0,0,0]] call ace_interact_menu_fnc_createAction;

    ["CAManBase", 1, ["ACE_SelfActions", "ACE_TeamManagement"], _action, true] call ace_interact_menu_fnc_addActionToClass;
};

player addEventHandler ["Respawn", {
    params ["_new", "_old"];
    [_old, _old getVariable [QGVAR(buddy), objNull], false] call FUNC(pairBuddies);
    _new setVariable [QGVAR(buddy), nil, true];
}];
