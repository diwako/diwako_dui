#include "..\script_component.hpp"

params [["_id", "", [""]], ["_color", GVAR(WaypointColor), [[]], [3, 4]], ["_position", [0,0,0], [[]], 3]];
GVAR(lineMarkers) set [_id, [_color, _position]];
