#include "script_component.hpp"

if (is3DEN || (!hasInterface || {side player == sideLogic}) && {player isKindOf "VirtualSpectator_F"} || !ADDON_MAIN) exitWith {};

FUNC(cacheLoop) call CBA_fnc_directCall;
