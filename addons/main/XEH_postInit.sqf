#include "script_component.hpp"
if (is3DEN || !hasInterface) exitWith {};

// cba eh for hiding the hud when in certain camera modes
["featureCamera", {
    params ["_player", "_featureCamera"];
    diwako_dui_inFeatureCamera = !(_featureCamera isEqualTo "");
}, true] call CBA_fnc_addPlayerEventHandler;
