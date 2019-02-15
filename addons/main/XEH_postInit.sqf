#include "script_component.hpp"
if (is3DEN || !hasInterface) exitWith {};

// cba eh for hiding the hud when in certain camera modes
["featureCamera", {
    params ["_player", "_featureCamera"];
    GVAR(inFeatureCamera) = !(_featureCamera isEqualTo "");
}, true] call CBA_fnc_addPlayerEventHandler;

// player remote controls another unit or changes avatar
// mainly used for the change in avatar / switch unit part as displays will be closed
["unit", {
    params ["_newPlayerUnit", "_oldPlayerUnit"];
    [QGVAR(refreshUI),[]] call CBA_fnc_localEvent;
}, true] call CBA_fnc_addPlayerEventHandler;

if (isClass (configfile >> "CfgPatches" >> "ace_nametags")) then {
    ["CBA_SettingChanged", {
        params ["_setting", "_value"];
        switch (_setting) do {
            case "ace_nametags_nametagColorMain": {
                EGVAR(main,colors_ace) setVariable ["main_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["main", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            case "ace_nametags_nametagColorRed": {
                EGVAR(main,colors_ace) setVariable ["red_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["red", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            case "ace_nametags_nametagColorGreen": {
                EGVAR(main,colors_ace) setVariable ["green_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["green", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            case "ace_nametags_nametagColorBlue": {
                EGVAR(main,colors_ace) setVariable ["blue_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["blue", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            case "ace_nametags_nametagColorYellow": {
                EGVAR(main,colors_ace) setVariable ["yellow_compass", _value select [0, 3]];
                EGVAR(main,colors_ace) setVariable ["yellow", [(_value select 0) * 255,(_value select 1) * 255,(_value select 2) * 255] call EFUNC(main,toHex)];
            };
            default { };
        };
    }] call CBA_fnc_addEventHandler;
};
