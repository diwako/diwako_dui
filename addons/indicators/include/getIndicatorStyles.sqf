private _configs = "true" configClasses (configFile >> "diwako_dui_indicator_style");
private _missionConfigs = "true" configClasses (missionConfigFile >> "diwako_dui_indicator_style");
if (isNil "_missionConfigs") then {
    _missionConfigs = [];
};

private _indicatorNames = [];
private _indicatorPaths = [];

{
    private _namespace = [] call CBA_fnc_createNamespace;
    private _configName = configName _x;
    _indicatorNames pushBack _configName;
    _indicatorPaths pushback getText (_x >> "name");

    _namespace setVariable ["indicator", getText (_x >> "indicator")];
    _namespace setVariable ["leader", getText (_x >> "leader")];
    _namespace setVariable ["medic", getText (_x >> "medic")];
    _namespace setVariable ["buddy", getText (_x >> "buddy")];
    missionNamespace setVariable [format[QGVAR(indicator_%1), _configName], _namespace];
} forEach (_configs + _missionConfigs);
