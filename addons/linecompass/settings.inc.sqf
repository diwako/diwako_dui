private _cat = format ["%1 - %2",localize "STR_dui_mod", localize "STR_dui_addon_linecompass"];

private _curCat = localize "STR_dui_cat_general";

[
    QGVAR(Enabled),
    "CHECKBOX",
    "STR_dui_linecompass_enabled",
    [_cat, _curCat],
    false,
    0,
    {
        params ["_value"];
        if (_value) then { call FUNC(showCompass); };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(CompassAvailableShown),
    "CHECKBOX",
    "STR_dui_linecompass_compass_required",
    [_cat, _curCat],
    true,
    1,
    {},
    true
] call CBA_fnc_addSetting;

[
    QGVAR(DrawBearing),
    "LIST",
    "STR_dui_linecompass_draw_directions",
    [_cat, _curCat],
    [[0, 1, 2], ["STR_dui_linecompass_draw_bearings_none", "STR_dui_linecompass_draw_bearings_bearings", "STR_dui_linecompass_draw_bearings_all"], 2]
] call CBA_fnc_addSetting;

[
    QGVAR(IconOutline),
    "LIST",
    "STR_dui_linecompass_icon_outline",
    [_cat, _curCat],
    [[0, 1, 2], ["STR_dui_namelist_text_shadow_0", "STR_dui_namelist_text_shadow_1", "STR_dui_namelist_text_shadow_2"], 0]
] call CBA_fnc_addSetting;

[
    QGVAR(DefaultIconColor),
    "COLOR",
    "STR_dui_linecompass_default_icon_color",
    [_cat, _curCat],
    [0.5, 0.87, 0.5, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(WaypointColor),
    "COLOR",
    "STR_dui_linecompass_default_waypoint_color",
    [_cat, _curCat],
    [0, 0, 0.87, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(CustomWaypointColor),
    "COLOR",
    "STR_dui_linecompass_default_waypoint_color",
    [_cat, _curCat],
    [0, 0, 0.87, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(ACEFingeringColor),
    "COLOR",
    "STR_dui_linecompass_ace_fingering_color",
    [_cat, _curCat],
    [1, 0.66, 0, 1]
] call CBA_fnc_addSetting;

[
    QGVAR(SwapOrder),
    "CHECKBOX",
    "STR_dui_linecompass_swap_order",
    [_cat, _curCat],
    false
] call CBA_fnc_addSetting;
