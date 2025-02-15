private _cat = format ["%1 - %2",localize "STR_dui_mod", localize "STR_dui_addon_linecompass"];

private _curCat = localize "STR_dui_cat_general";

[
    QGVAR(Enabled),
    "CHECKBOX",
    "Enabled",
    [_cat, _curCat],
    GVAR(CompassAvailableShown),
    1,
    {
        params ["_value"];

        if (_value) then { call FUNC(showCompass); };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(CompassAvailableShown),
    "CHECKBOX",
    "Show Only When Compass is Available",
    [_cat, _curCat],
    GVAR(CompassAvailableShown),
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(DrawBearing),
    "LIST",
    "Directions Drawn",
    [_cat, _curCat],
    [[0, 1, 2], ["None", "Bearing", "All"], 2]
] call CBA_fnc_addSetting;

[
    QGVAR(IconOutline),
    "LIST",
    "Icon Outline",
    [_cat, _curCat],
    [[0, 1, 2], ["None", "Shadow", "Outline"], 2]
] call CBA_fnc_addSetting;

[
    QGVAR(DefaultIconColor),
    "COLOR",
    "Default Icon Color",
    [_cat, _curCat],
    [0, 0.87, 0, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(WaypointColor),
    "COLOR",
    "Default Icon Color",
    [_cat, _curCat],
    [0.9, 0.66, 0.01, 1]
] call CBA_fnc_addSetting;
