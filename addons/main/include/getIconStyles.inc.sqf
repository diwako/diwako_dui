private _configs = "true" configClasses (configFile >> "diwako_dui_icon_style");
private _missionConfigs = "true" configClasses (missionConfigFile >> "diwako_dui_icon_style");
if (isNil "_missionConfigs") then {
    _missionConfigs = [];
};

private _iconNames = [];
private _iconIdent = [];

{
    private _namespace = [] call CBA_fnc_createNamespace;
    private _config = _x;
    _iconNames pushBack getText (_config >> "name");
    private _configName = configName _x;
    _iconIdent pushBack _configName;

    {
        _namespace setVariable [configName _x, getText _x];
    } forEach (configProperties [_config, "(configname _x select [0,5]) != 'rank_'", true]);

    _namespace setVariable ["PRIVATE", getText (_config >> "rank_private")];
    _namespace setVariable ["CORPORAL", getText (_config >> "rank_corporal")];
    _namespace setVariable ["SERGEANT", getText (_config >> "rank_sergeant")];
    _namespace setVariable ["LIEUTENANT", getText (_config >> "rank_lieutenant")];
    _namespace setVariable ["CAPTAIN", getText (_config >> "rank_captain")];
    _namespace setVariable ["MAJOR", getText (_config >> "rank_major")];
    _namespace setVariable ["COLONEL", getText (_config >> "rank_colonel")];

    missionNamespace setVariable [format[QGVAR(icon_%1), _configName], _namespace]
} forEach (_configs + _missionConfigs);
