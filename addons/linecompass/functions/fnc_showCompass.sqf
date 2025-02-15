#include "..\script_component.hpp"
/*
 * Authors: joko // Jonas
 *
 *
 * Arguments:
 *
 *
 * Return Value:
 *
 *
 * Example:
 * 10 call dui_linecompass_fnc_getAlphaFromX
 *
 * Public: No
 */

// Reset the cache
GVAR(lineAlphaCache) = GVAR(lineAlphaCache) apply {1};
GVAR(bearingAlphaCache) = GVAR(bearingAlphaCache) apply {1};
GVAR(CompassShown) = true;
// Show the compass and make sure it is not shown if the map is open
([QGVAR(Compass)] call BIS_fnc_rscLayer) cutRsc [QGVAR(Compass), "PLAIN", 0, false];
