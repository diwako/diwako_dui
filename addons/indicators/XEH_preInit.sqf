#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#define CBA_SETTINGS_CAT (format ["%1 - %2",localize "STR_dui_mod", localize "STR_dui_addon_indicators"])

[
    QGVAR(show)
    ,"CHECKBOX"
    ,[localize "STR_dui_indicators_show", localize "STR_dui_indicators_show_desc"]
    ,CBA_SETTINGS_CAT
    ,true
] call CBA_Settings_fnc_init;

#define DUI_INDICATORS_MIN_RANGE 15
#define DUI_INDICATORS_MAX_RANGE 50
[
    QGVAR(range)
    ,"SLIDER"
    ,[localize "STR_dui_indicators_range", localize "STR_dui_indicators_range_desc"]
    ,CBA_SETTINGS_CAT
    ,[DUI_INDICATORS_MIN_RANGE, DUI_INDICATORS_MAX_RANGE, 20, 0]
    ,false
] call CBA_Settings_fnc_init;

#include "include\getIndicatorStyles.sqf"
[
    QGVAR(style)
    ,"LIST"
    ,[localize "STR_dui_indicators_style", localize "STR_dui_indicators_style_desc"]
    ,CBA_SETTINGS_CAT
    ,[
        _indicatorNames,
        _indicatorPaths,
        0
    ]
    ,false
] call CBA_Settings_fnc_init;

ADDON = true;
