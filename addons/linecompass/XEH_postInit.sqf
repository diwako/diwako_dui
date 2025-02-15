#include "script_component.hpp"
if (is3DEN || (!hasInterface || {side player == sideLogic}) && {player isKindOf "VirtualSpectator_F"}) exitWith {};
// waitUntil {!isNull findDisplay 46}; // TODO
call FUNC(showCompass);
GVAR(drawEh) = addMissionEventHandler ["Draw3D", {call FUNC(draw3D)}];
