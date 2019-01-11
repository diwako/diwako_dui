private _configs = "true" configClasses (configFile >> "diwako_dui_colors");
private _missionConfigs = "true" configClasses (missionConfigFile >> "diwako_dui_colors");

private _colorNames = [];
private _namespaces = [];

{
	private _namespace = [] call CBA_fnc_createNamespace;
	_colorNames pushback getText (_x >> "name");

	_namespace setVariable ["MAIN", getText (_x >> "white")];
	_namespace setVariable ["RED", getText (_x >> "red")];
	_namespace setVariable ["GREEN", getText (_x >> "green")];
	_namespace setVariable ["BLUE", getText (_x >> "blue")];
	_namespace setVariable ["YELLOW", getText (_x >> "yellow")];
	_namespaces pushBack _namespace;
} forEach (_configs + _missionConfigs);

[_colorNames, _namespaces]
