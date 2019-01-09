private _configs = "true" configClasses (configFile >> "diwako_dui_colors");

private _colorNames = [];
private _colorPaths = [];

{
	private _colors = [];
	_colorNames pushback getText (_x >> "name");
	_colors pushBack getText (_x >> "white");
	_colors pushBack getText (_x >> "red");
	_colors pushBack getText (_x >> "green");
	_colors pushBack getText (_x >> "blue");
	_colors pushBack getText (_x >> "yellow");
	_colorPaths pushBack _colors;
} forEach _configs;

private _configs = "true" configClasses (missionConfigFile >> "diwako_dui_colors");

{
	private _colors = [];
	_colorNames pushback getText (_x >> "name");
	_colors pushBack getText (_x >> "white");
	_colors pushBack getText (_x >> "red");
	_colors pushBack getText (_x >> "green");
	_colors pushBack getText (_x >> "blue");
	_colors pushBack getText (_x >> "yellow");
	_colorPaths pushBack _colors;
} forEach _configs;

[_colorNames, _colorPaths]