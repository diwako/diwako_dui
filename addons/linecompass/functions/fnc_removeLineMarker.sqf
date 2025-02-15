#include "..\script_component.hpp"
/*
    Line Compass

    Author: joko // Jonas

    Description:
    Remove a Position from the Compass

    Parameter(s):
    0: Marker ID <String>

    Returns:
    None
*/
params ["_id"];
GVAR(lineMarkers) deleteAt _id;
