#include "script_component.hpp"

if (is3DEN || (!hasInterface || {side player == sideLogic}) && {player isKindOf "VirtualSpectator_F"}) exitWith {};

[{ call FUNC(cacheLoop);}, [], 0.1] call CBA_fnc_waitUntil;
