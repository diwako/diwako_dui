#include "script_component.hpp"

if (is3DEN || (!hasInterface || {side player == sideLogic}) && {player isKindOf "VirtualSpectator_F"}) exitWith {};

FUNC(cacheLoop) call CBA_fnc_directCall;
