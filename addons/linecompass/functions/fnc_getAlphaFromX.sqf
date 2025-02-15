#include "..\script_component.hpp"
/*
 * Authors: joko // Jonas
 * get Alpha from X Position.
 *
 * Arguments:
 * 0: X Position <NUMBER>
 *
 * Return Value:
 * Alpha Value <NUMBER>
 *
 * Example:
 * 10 call dui_linecompass_fnc_getAlphaFromX
 *
 * Public: No
 */

params [["_value", 0, [0]]];
TRACE_1("fnc_getAlphaFromX",_this);

(3 - (abs (_value - 92.5) / 30)) max 0
