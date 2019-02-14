#include "script_component.hpp"
if (is3DEN || !hasInterface) exitWith {};

// cba eh for hiding the hud when in certain camera modes
["featureCamera", {
    params ["_player", "_featureCamera"];
    GVAR(inFeatureCamera) = !(_featureCamera isEqualTo "");
}, true] call CBA_fnc_addPlayerEventHandler;

// player remote controls another unit or changes avatar
// mainly used for the change in avatar / switch unit part as displays will be closed
["unit", {
    params ["_newPlayerUnit", "_oldPlayerUnit"];
    [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
}, true] call CBA_fnc_addPlayerEventHandler;
