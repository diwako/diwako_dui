#include "..\script_component.hpp"

params [["_value", 0, [0]]];
(3 - (abs (_value - 92.5) / 30)) max 0
