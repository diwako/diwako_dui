#include "script_component.hpp"
/*
 * Ported to DUI from ACE common
 * Original header:
 *
 * Author: commy2, idea by Falke
 * Returns a brightness value depending on the sun and moon state. Ranges from 0 to 1 (dark ... bright).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Ambient brightness <NUMBER>
 *
 * Example:
 * [] call dui_main_fnc_ambientBrightness
 *
 * Public: Yes
 */

(sunOrMoon * sunOrMoon * (1 - overcast * 0.25) + (moonIntensity / 5) * (1 - overcast)) min 1
