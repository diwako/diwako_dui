private _configs = "true" configClasses (configFile >> "diwako_dui_compass_style");

private _compassNames = [];
private _compassPaths = [];

{
	_compassNames pushback getText (_x >> "name");
	_compassPaths pushBack [getText (_x >> "limited"), getText (_x >> "full")];
} forEach _configs;

private _configs = "true" configClasses (missionConfigFile >> "diwako_dui_compass_style");

{
	_compassNames pushback getText (_x >> "name");
	_compassPaths pushBack [getText (_x >> "limited"), getText (_x >> "full")];
} forEach _configs;

[_compassNames, _compassPaths]