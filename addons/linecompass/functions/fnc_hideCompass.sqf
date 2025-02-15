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

([QGVAR(Compass)] call BIS_fnc_rscLayer) cutFadeOut 0;
GVAR(CompassShown) = false;
