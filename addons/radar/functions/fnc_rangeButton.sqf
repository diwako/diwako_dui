#include "script_component.hpp"
params [["_increase",true, [true]]];

diwako_dui_compassRange = DUI_MAX_RANGE min (diwako_dui_compassRange + ([-5,5] select _increase)) max DUI_MIN_RANGE;
