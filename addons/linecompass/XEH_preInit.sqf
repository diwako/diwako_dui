#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(drawEh) = -1;

GVAR(lineMarkers) = createHashMap;

// Use pools to store the controls for the markers
GVAR(lineMarkerControlPool) = [];
GVAR(iconMarkerControlPool) = [];

// Caches for alpha values
GVAR(lineAlphaCache) = [];
GVAR(lineAlphaCache) resize 109;
GVAR(bearingAlphaCache) = [];
GVAR(bearingAlphaCache) resize 37;

GVAR(GroupColor) = [0, 0.87, 0, 1];
GVAR(SideColor) = [0, 0.4, 0.8, 1];
GVAR(WaypointColor) = [0.9, 0.66, 0.01, 1];
GVAR(CompassAvailableShown) = false;
GVAR(DrawBearing) = 2;

GVAR(UnitDistance) = 15;

[
    QGVAR(CompassAvailableShown),
    "CHECKBOX",
    "Show Only When Compass is Available",
    "Line Compass",
    GVAR(CompassAvailableShown),
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(GroupColor),
    "COLOR",
    "Group Color",
    "Line Compass",
    GVAR(GroupColor)
] call CBA_fnc_addSetting;

[
    QGVAR(SideColor),
    "COLOR",
    "Side Color",
    "Line Compass",
    GVAR(SideColor)
] call CBA_fnc_addSetting;

[
    QGVAR(WaypointColor),
    "COLOR",
    "Waypoint Color",
    "Line Compass",
    GVAR(WaypointColor),
    nil,
    {
        params ["_value"];
        if (customWaypointPosition isNotEqualTo []) then {
            ["MOVE", _value, customWaypointPosition] call FUNC(addLineMarker);
        };
    }
] call CBA_fnc_addSetting;

[
    QGVAR(DrawBearing),
    "LIST",
    "Directions Drawn",
    "Line Compass",
    [[0, 1, 2], ["None", "Bearing", "All"], 2]
] call CBA_fnc_addSetting;

GVAR(fingerTime) = time;

["ace_finger_fingered", {
    params ["_player", "_pos", "_dir"];
    ["Fingering", GVAR(WaypointColor), _pos] call FUNC(addLineMarker);
    GVAR(fingerTime) = time + 2.5;
}] call CBA_fnc_addEventhandler;

ADDON = true;
