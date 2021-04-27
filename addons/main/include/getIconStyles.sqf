#ifndef MAINPREFIX
    #include "..\script_component.hpp"
#endif
private _configs = "true" configClasses (configFile >> "diwako_dui_icon_style");
private _missionConfigs = "true" configClasses (missionConfigFile >> "diwako_dui_icon_style");
if (isNil "_missionConfigs") then {
    _missionConfigs = [];
};

private _iconNames = [];
private _iconIdent = [];

{
    private _namespace = [] call CBA_fnc_createNamespace;
    _iconNames pushback getText (_x >> "name");
    private _configName = configName _x;
    _iconIdent pushBack _configName;

    _namespace setVariable ["sql", getText (_x >> "sql")];
    _namespace setVariable ["medic", getText (_x >> "medic")];
    _namespace setVariable ["auto_rifleman", getText (_x >> "auto_rifleman")];
    _namespace setVariable ["at_gunner", getText (_x >> "at_gunner")];
    _namespace setVariable ["engineer", getText (_x >> "engineer")];
    _namespace setVariable ["explosive_specialist", getText (_x >> "explosive_specialist")];
    _namespace setVariable ["rifleman", getText (_x >> "rifleman")];
    _namespace setVariable ["vehicle_cargo", getText (_x >> "vehicle_cargo")];
    _namespace setVariable ["vehicle_driver", getText (_x >> "vehicle_driver")];
    _namespace setVariable ["fire_from_vehicle", getText (_x >> "fire_from_vehicle")];
    _namespace setVariable ["vehicle_gunner", getText (_x >> "vehicle_gunner")];
    _namespace setVariable ["vehicle_commander", getText (_x >> "vehicle_commander")];
    _namespace setVariable ["PRIVATE", getText (_x >> "rank_private")];
    _namespace setVariable ["CORPORAL", getText (_x >> "rank_corporal")];
    _namespace setVariable ["SERGEANT", getText (_x >> "rank_sergeant")];
    _namespace setVariable ["LIEUTENANT", getText (_x >> "rank_lieutenant")];
    _namespace setVariable ["CAPTAIN", getText (_x >> "rank_captain")];
    _namespace setVariable ["MAJOR", getText (_x >> "rank_major")];
    _namespace setVariable ["COLONEL", getText (_x >> "rank_colonel")];
    _namespace setVariable ["buddy", getText (_x >> "buddy")];
    _namespace setVariable ["buddy_compass", getText (_x >> "buddy_compass")];
    _namespace setVariable ["speaking", getText (_x >> "speaking")];
    _namespace setVariable ["speakingRadio", getText (_x >> "speakingRadio")];

    missionNamespace setVariable [format[QGVAR(icon_%1), _configName], _namespace]
} forEach (_configs + _missionConfigs);
