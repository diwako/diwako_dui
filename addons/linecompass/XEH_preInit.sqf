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

GVAR(customWaypointPosition) = customWaypointPosition;

GVAR(UnitsToRender) = [];

if (isClass(configFile >> "CfgPatches" >> "ace_finger")) then {

    ["ace_finger_fingered", {

        params ["_player", "_pos"];

        private _key = format ["ACE_Fingering_%1", hashValue _player];
        [_key, _pos, GVAR(ACEFingeringColor)] call FUNC(addLineMarker);

        [{
            _this call FUNC(removeLineMarker);
        }, _key, 2.5] call CBA_fnc_waitAndExecute;
    }] call CBA_fnc_addEventhandler;
};

#include "settings.inc.sqf"

ADDON = true;
