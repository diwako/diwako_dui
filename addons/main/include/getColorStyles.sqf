#ifndef MAINPREFIX
    #include "..\script_component.hpp"
#endif
private _configs = "true" configClasses (configFile >> "diwako_dui_colors");
private _missionConfigs = "true" configClasses (missionConfigFile >> "diwako_dui_colors");
if (isNil "_missionConfigs") then {
    _missionConfigs = [];
};

private _colorNames = [];
private _colorIdent = [];

private _getColorFromHex = {
    params ["_key", "_hex"];
    _hex = toArray _hex;
    _hex deleteAt 0; //remove the '#' at the beginning
    private _nums = toArray "0123456789ABCDEF"; //for converting hex nibbles to base 10 equivalents

    private _r = (_nums find (_hex select 0)) * 16 + (_nums find (_hex select 1));
    private _g = (_nums find (_hex select 2)) * 16 + (_nums find (_hex select 3));
    private _b = (_nums find (_hex select 4)) * 16 + (_nums find (_hex select 5));

    _namespace setVariable [format ["%1_compass",_key], [(_r/255),(_g/255),(_b/255)]];
};

{
    private _namespace = [] call CBA_fnc_createNamespace;
    private _configName = configName _x;
    _colorIdent pushBack _configName;
    _colorNames pushback getText (_x >> "name");

    _namespace setVariable ["main", getText (_x >> "white")];
    ["main", _namespace getVariable "main"] call _getColorFromHex;
    _namespace setVariable ["red", getText (_x >> "red")];
    ["red", _namespace getVariable "red"] call _getColorFromHex;
    _namespace setVariable ["green", getText (_x >> "green")];
    ["green", _namespace getVariable "green"] call _getColorFromHex;
    _namespace setVariable ["blue", getText (_x >> "blue")];
    ["blue", _namespace getVariable "blue"] call _getColorFromHex;
    _namespace setVariable ["yellow", getText (_x >> "yellow")];
    ["yellow", _namespace getVariable "yellow"] call _getColorFromHex;

    missionNamespace setVariable [format[QGVAR(colors_%1), _configName], _namespace]
} forEach (_configs + _missionConfigs);

// custom colors
private _namespace = [] call CBA_fnc_createNamespace;
_colorIdent pushBack "custom";
_colorNames pushBack (localize "STR_dui_color_custom");
_namespace setVariable ["main_compass", [1,1,1]];
_namespace setVariable ["main", "#FFFFFF"];
_namespace setVariable ["red_compass", [1,0,0]];
_namespace setVariable ["red", "#FF0000"];
_namespace setVariable ["green_compass", [0,1,0]];
_namespace setVariable ["green", "#00FF00"];
_namespace setVariable ["blue_compass", [0,0,1]];
_namespace setVariable ["blue", "#0000FF"];
_namespace setVariable ["yellow_compass", [1,1,0]];
_namespace setVariable ["yellow", "#FFFF00"];
GVAR(colors_custom) = _namespace;

// ACE name tags support
if (isClass (configfile >> "CfgPatches" >> "ace_nametags")) then {
    // ace nametags is also loaded, provide ace nametag colors as well
    _namespace = missionNamespace getVariable QGVAR(colors_ace);
    if (isNil "_namespace") then {
        _namespace = [] call CBA_fnc_createNamespace;
        _colorIdent pushBack "ace";
        _colorNames pushBack (localize "STR_dui_color_ace");
        missionNamespace setVariable [QGVAR(colors_ace), _namespace];
    };
    private _main = ["ace_nametags_nametagColorMain"] call CBA_settings_fnc_get;
    private _red = ["ace_nametags_nametagColorRed"] call CBA_settings_fnc_get;
    private _green = ["ace_nametags_nametagColorGreen"] call CBA_settings_fnc_get;
    private _blue = ["ace_nametags_nametagColorBlue"] call CBA_settings_fnc_get;
    private _yellow = ["ace_nametags_nametagColorYellow"] call CBA_settings_fnc_get;

    _namespace setVariable ["main_compass", _main select [0, 3]];
    _namespace setVariable ["red_compass", _red select [0, 3]];
    _namespace setVariable ["green_compass", _green select [0, 3]];
    _namespace setVariable ["blue_compass", _blue select [0, 3]];
    _namespace setVariable ["yellow_compass", _yellow select [0, 3]];
    _namespace setVariable ["main", [(_main select 0) * 255,(_main select 1) * 255,(_main select 2) * 255] call EFUNC(main,toHex)];
    _namespace setVariable ["red", [(_red select 0) * 255,(_red select 1) * 255,(_red select 2) * 255] call EFUNC(main,toHex)];
    _namespace setVariable ["green", [(_green select 0) * 255,(_green select 1) * 255,(_green select 2) * 255] call EFUNC(main,toHex)];
    _namespace setVariable ["blue", [(_blue select 0) * 255,(_blue select 1) * 255,(_blue select 2) * 255] call EFUNC(main,toHex)];
    _namespace setVariable ["yellow", [(_yellow select 0) * 255,(_yellow select 1) * 255,(_yellow select 2) * 255] call EFUNC(main,toHex)];
};
