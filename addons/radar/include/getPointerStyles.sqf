private _configs = "true" configClasses (configFile >> QGVAR(pointers));
private _missionConfigs = "true" configClasses (missionConfigFile >> QGVAR(pointers));
if (isNil "_missionConfigs") then {
    _missionConfigs = [];
};

private _pointerClasses = [];
private _pointerNames = [];
GVAR(pointerPaths) = [] call CBA_fnc_createNamespace;

{
    _pointerClasses pushBack (configName _x);
    _pointerNames pushback getText (_x >> "name");
    GVAR(pointerPaths) setVariable [(configName _x), getText (_x >> "file")];
} forEach (_configs + _missionConfigs);
