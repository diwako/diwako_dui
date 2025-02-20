#include "..\script_component.hpp"

// Reset the cache
GVAR(lineAlphaCache) = GVAR(lineAlphaCache) apply {1};
GVAR(bearingAlphaCache) = GVAR(bearingAlphaCache) apply {1};
GVAR(CompassShown) = true;
// Show the compass and make sure it is not shown if the map is open
([QGVAR(Compass)] call BIS_fnc_rscLayer) cutRsc [QGVAR(Compass), "PLAIN", 0, false];

GVAR(drawEh) = addMissionEventHandler ["Draw3D", {call FUNC(onDraw)}];
