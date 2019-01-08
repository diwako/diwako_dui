private _configs = "true" configClasses (configFile >> "diwako_dui_icon_style");

private _iconNames = [];
private _iconPaths = [];

{
	private _paths = [];
	_iconNames pushback getText (_x >> "name");
	_paths pushBack getText (_x >> "sql");
	_paths pushBack getText (_x >> "medic");
	_paths pushBack getText (_x >> "auto_rifleman");
	_paths pushBack getText (_x >> "at_gunner");
	_paths pushBack getText (_x >> "engineer");
	_paths pushBack getText (_x >> "explosive_specialist");
	_paths pushBack getText (_x >> "rifleman");
	_paths pushBack getText (_x >> "vehicle_cargo");
	_paths pushBack getText (_x >> "vehicle_driver");
	_paths pushBack getText (_x >> "fire_from_vehicle");
	_paths pushBack getText (_x >> "vehicle_gunner");
	_paths pushBack getText (_x >> "vehicle_commander");
	_iconPaths pushBack _paths;
} forEach _configs;

private _configs = "true" configClasses (missionConfigFile >> "diwako_dui_icon_style");

{
	private _paths = [];
	_iconNames pushback getText (_x >> "name");
	_paths pushBack getText (_x >> "sql");
	_paths pushBack getText (_x >> "medic");
	_paths pushBack getText (_x >> "auto_rifleman");
	_paths pushBack getText (_x >> "at_gunner");
	_paths pushBack getText (_x >> "engineer");
	_paths pushBack getText (_x >> "explosive_specialist");
	_paths pushBack getText (_x >> "rifleman");
	_paths pushBack getText (_x >> "vehicle_cargo");
	_paths pushBack getText (_x >> "vehicle_driver");
	_paths pushBack getText (_x >> "fire_from_vehicle");
	_paths pushBack getText (_x >> "vehicle_gunner");
	_paths pushBack getText (_x >> "vehicle_commander");
	_iconPaths pushBack _paths;
} forEach _configs;

[_iconNames, _iconPaths]