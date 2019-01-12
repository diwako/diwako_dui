private _configs = "true" configClasses (configFile >> "diwako_dui_compass_style");
private _missionConfigs = "true" configClasses (missionConfigFile >> "diwako_dui_compass_style");
if (isNil "_missionConfigs") then {
	_missionConfigs = [];
};

private _compassNames = [];
private _compassPaths = [];

{
	_compassNames pushback getText (_x >> "name");
	_compassPaths pushBack [getText (_x >> "limited"), getText (_x >> "full")];
} forEach (_configs + _missionConfigs);

[_compassNames, _compassPaths]
