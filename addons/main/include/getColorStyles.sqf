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
    _namespace setVariable ["tracked", getText (_x >> "tracked")];
    ["tracked", _namespace getVariable "tracked"] call _getColorFromHex;

    missionNamespace setVariable [format["diwako_dui_colors_%1", _configName], _namespace]
} forEach (_configs + _missionConfigs);
