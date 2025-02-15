#include "..\script_component.hpp"
/*
    Line Compass

    Author: joko // Jonas, NetFusion

    Description:
    Add a compass line marker to the compass hub.

    Parameter(s):
    0: Id <String>
    1: Color <Array>
    2: Position <Array>

    Returns:
    None
*/
params ["_id", "_color", "_position"];
GVAR(lineMarkers) set [_id, [_color, _position]];
