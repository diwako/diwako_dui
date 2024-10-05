#include "script_component.hpp"
params ["_player"];
!(
    GVAR(toggled_off) ||
    {!alive _player ||
    {(_player getVariable ["ace_spectator_isSet", false]) ||
    {(_player getVariable ["ACE_isUnconscious", false]) ||
    GVAR(radioModSpectator) ||
    {_player isKindOf "VirtualSpectator_F" ||
    {GVAR(hide_dialog) && {dialog} ||
    {diwako_dui_ace_hide_interaction && {missionNamespace getVariable ["ace_interact_menu_openedMenuType",-1] > -1} ||
    {!isNull (missionNamespace getVariable ["ace_arsenal_camera", objNull]) ||
    {GVAR(inFeatureCamera)}}}}}}}}
)
