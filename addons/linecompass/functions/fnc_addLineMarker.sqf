#include "..\script_component.hpp"

params ["_id", "_color", "_position"];
GVAR(lineMarkers) set [_id, [_color, _position]];
